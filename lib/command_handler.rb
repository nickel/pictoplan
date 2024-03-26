# frozen_string_literal: true

require "active_support/concern"
require "active_support/notifications"

require_relative "command_handler/callable"
require_relative "command_handler/configurable"
require_relative "command_handler/response"
require_relative "command_handler/error"
require_relative "command_handler/form"
require_relative "command_handler/errors"
require_relative "command_handler/command"

module CommandHandler
  extend ActiveSupport::Concern
  class NoResponseObjectException < StandardError; end

  class << self
    include Configurable
  end

  class_methods do
    def invoke_command( # rubocop:disable Metrics/ParameterLists
      authorizable: nil,
      command_name: nil,
      command: nil,
      required_permissions: [],
      input: nil,
      options: {},
      &block
    )
      command_name ||= "#{self}.#{caller_locations(1, 1).first.label}"

      instrumentation_opts = { command_name:, input:, options: }

      ActiveSupport::Notifications.instrument("jt.command", **instrumentation_opts) do
        call_auth_handler(authorizable, required_permissions, command_name, input, options)
          .and_then do |authorizable_authorized|
          response = call_command(command, input, authorizable_authorized, options, &block)

          raise_no_response_object_exception unless response.is_a?(Response)

          call_audit_handler(command_name, response, input)
          call_metric_handler(command_name, response, options:)

          response.with_meta(authorizable: authorizable_authorized)
        end
      end
    end

    private

    def call_auth_handler(authorizable, required_permissions, command_name, input, options)
      return Response.success(AuthDisabledUser.new) if options[:disable_auth] || JT::CommandHandler.disable_auth

      return Response.success(authorizable) if authorizable.has_permissions?(required_permissions)

      build_forbidden_error_response(required_permissions:).tap do |response|
        call_audit_handler(command_name, response, input)
        call_metric_handler(command_name, response, options:)
      end
    end

    def call_audit_handler(command_name, response, input)
      AuditHandler.call(command_name:, succeeded: response.success?, **input)
    end

    def call_metric_handler(command_name, response, options: {})
      MetricHandler.call(command_name:, succeeded: response.success?,
                         tags: options[:tags] || {})
    end

    def call_command(command, input, authorizable, options)
      if block_given?
        yield(input, authorizable)
      elsif options[:command_exec_instance_method]
        command.new(**input).public_send(options[:command_exec_instance_method])
      else
        command.call(**input)
      end
    end

    def raise_no_response_object_exception
      raise NoResponseObjectException.new(
        "Command must return a Response object. " \
        "Check: https://www.notion.so/jtproduct/Response-Object-c484e953f76e4ca4baab2dbf94265692"
      )
    end

    def build_forbidden_error_response(required_permissions:)
      CommandHandler::Errors::ForbiddenError.build(
        required_permissions:
      ).as_response
    end
  end
end

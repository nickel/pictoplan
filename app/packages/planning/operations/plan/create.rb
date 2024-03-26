# frozen_string_literal: true

class Plan::Create < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :account_id, :integer
    attribute :name, :string

    validates :account_id, presence: true
    validates :name, presence: true
  end

  delegate :account_id, :name, to: :form

  def execute
    Plan
      .new(account_id:, name:)
      .save_with_response
      .and_then do |plan|
        Response.success(plan.to_struct)
      end
  end
end

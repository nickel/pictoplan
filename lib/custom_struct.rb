# frozen_string_literal: true

class CustomStruct < OpenStruct
  include ActiveModel::Serialization

  def read_attribute_for_serialization(attr)
    send(attr) if defined?(attr)
  end

  def attributes
    instance_variable_get("@table")
  end
end

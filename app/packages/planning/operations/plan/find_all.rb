# frozen_string_literal: true

class Plan::FindAll < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :account_id, :integer

    validates :account_id, presence: true
  end

  delegate(*Form.new.attributes.keys, to: :form)

  def execute
    Response.success(
      Plan
        .where(account_id:)
        .map(&:to_struct)
    )
  end
end

# frozen_string_literal: true

class Plan::Create < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :account_id, :integer
    attribute :name, :string

    validates :account_id, presence: true
    validates :name, presence: true
  end

  def execute
    Plan
      .new(
        account_id:,
        name:,
        status: Plan::AVAILABLE
      ).save_with_response
  end
end

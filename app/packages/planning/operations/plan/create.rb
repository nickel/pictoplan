# frozen_string_literal: true

class Plan::Create < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :user_id, :integer
    attribute :name, :string

    validates :user_id, presence: true
    validates :name, presence: true
  end

  def execute
    Plan
      .new(
        user_id:,
        name:,
        status: Plan::AVAILABLE
      ).save_with_response
  end
end

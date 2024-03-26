# frozen_string_literal: true

class Plan::Update < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :account_id, :integer
    attribute :plan_id, :integer
    attribute :name, :string

    validates :account_id, presence: true
    validates :plan_id, presence: true
    validates :name, presence: true
  end

  delegate :account_id, :plan_id, :name, to: :form

  def execute
    Plan::Find
      .call(account_id:, plan_id:)
      .and_then do
        Plan
          .find_by(id: plan_id)
          .update_with_response(name:)
          .and_then do |plan|
            Response.success(plan.to_struct)
          end
      end
  end
end

# frozen_string_literal: true

class Plan::Activate < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :account_id, :integer
    attribute :plan_id, :integer

    validates :account_id, presence: true
    validates :plan_id, presence: true
  end

  delegate :account_id, :plan_id, to: :form

  def execute
    Plan::Find
      .call(account_id:, plan_id:)
      .and_then do
        Plan
          .where(account_id:)
          .update(active: false)

        Plan
          .find_by(id: plan_id)
          .update_with_response(active: true)
          .and_then do |updated_plan|
            Response.success(updated_plan.to_struct)
          end
      end
  end
end

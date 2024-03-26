# frozen_string_literal: true

class Plan::Remove < CommandHandler::Command
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
      .and_then do |plan|
        Response.success(
          Plan
            .destroy(plan.id)
            .to_struct
        )
      end
  end
end

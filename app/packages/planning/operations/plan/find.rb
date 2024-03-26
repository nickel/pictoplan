# frozen_string_literal: true

class Plan::Find < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :account_id, :integer
    attribute :plan_id, :integer

    validates :account_id, presence: true
    validates :plan_id, presence: true
  end

  delegate :account_id, :plan_id, to: :form

  def execute
    if (plan = Plan.find_by(id: plan_id, account_id:))
      Response.success(plan.to_struct)
    else
      Response.failure(
        Errors::RecordNotFoundError
          .build(form:)
      )
    end
  end
end

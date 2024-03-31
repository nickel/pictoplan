# frozen_string_literal: true

class Plan::FindCurrent < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :account_id, :integer

    validates :account_id, presence: true
  end

  delegate :account_id, :plan_id, to: :form

  def execute
    if (plan = Plan.find_by(account_id:, active: true))
      Response.success(plan.to_struct)
    else
      Response.failure(
        Errors::RecordNotFoundError
          .build(form:)
      )
    end
  end
end

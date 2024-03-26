# frozen_string_literal: true

class Plan::Find < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :user_id, :integer
    attribute :plan_id, :integer

    validates :user_id, presence: true
    validates :plan_id, presence: true
  end

  def execute
    if (plan = Plan.find_by(user_id:, plan_id:))
      plan.destroy_with_response

      Response.success(plan.to_struct)
    else
      Response.failure(
        Errors::RecordNotFoundError
          .build(form:)
      )
    end
  end
end

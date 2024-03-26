# frozen_string_literal: true

class Plan::Activate < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :user_id, :integer
    attribute :plan_id, :integer

    validates :user_id, presence: true
    validates :plan_id, presence: true
  end

  def execute
    if (plan = Plan.find_by(user_id:, plan_id:))
      Plan
        .where(user_id:)
        .update(active: false)

      plan
        .update_with_response(active: true)
        .and_then do |updated_plan|
          Response.success(updated_plan.to_struct)
        end
    else
      Response.failure(
        Errors::RecordNotFoundError
          .build(form:)
      )
    end
  end
end

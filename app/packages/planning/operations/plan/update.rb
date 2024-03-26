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

  def execute
    if (plan = Plan.find_by(account_id:, plan_id:))
      plan
        .update_with_response(name:)

      Response.success(plan.to_struct)
    else
      Response.failure(
        Errors::RecordNotFoundError
          .build(form:)
      )
    end
  end
end

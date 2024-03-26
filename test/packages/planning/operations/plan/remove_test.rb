# frozen_string_literal: true

require "test_helper"

class Plan::RemoveTest < ActiveSupport::TestCase
  test "plan is removed" do
    account = Factory.generate_account
    plan = Factory.generate_plan(account_id: account.id)

    response = Plan::Remove
      .call(account_id: account.id, plan_id: plan.id)

    assert response.success?
  end
end

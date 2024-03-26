# frozen_string_literal: true

require "test_helper"

class Plan::FindTest < ActiveSupport::TestCase
  test "plan can be found with the proper values" do
    account = Factory.generate_account
    plan = Factory.generate_plan(account_id: account.id)

    response = Plan::Find
      .call(account_id: account.id, plan_id: plan.id)

    assert response.success?
  end

  test "plan can not be found when plan doesn't belongs to the account" do
    account = Factory.generate_account
    random_account = Factory.generate_account
    plan = Factory.generate_plan(account_id: account.id)

    response = Plan::Find
      .call(account_id: random_account.id, plan_id: plan.id)

    assert response.failure?
  end
end

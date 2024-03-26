# frozen_string_literal: true

require "test_helper"

class Plan::ActivateTest < ActiveSupport::TestCase
  test "plan is activated" do
    account = Factory.generate_account
    plan = Factory.generate_plan(account_id: account.id)

    refute plan.active?

    response = Plan::Activate
      .call(account_id: account.id, plan_id: plan.id)

    assert response.success?
    assert response.value.active?
  end

  test "plan is inactive when other is activated" do
    account = Factory.generate_account
    plan = Factory.generate_plan(account_id: account.id)

    Plan::Activate
      .call(account_id: account.id, plan_id: plan.id)

    Plan::Find
      .call(account_id: account.id, plan_id: plan.id)
      .and_then do |refreshed_plan|
        assert refreshed_plan.active?
      end

    new_plan = Factory.generate_plan(account_id: account.id)

    Plan::Activate
      .call(account_id: account.id, plan_id: new_plan.id)

    Plan::Find
      .call(account_id: account.id, plan_id: plan.id)
      .and_then do |refreshed_plan|
        refute refreshed_plan.active?
      end
  end
end

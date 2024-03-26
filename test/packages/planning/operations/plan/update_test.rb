# frozen_string_literal: true

require "test_helper"

class Plan::UpdateTest < ActiveSupport::TestCase
  test "plan creation with the proper values" do
    account = Factory.generate_account
    plan = Factory.generate_plan(account_id: account.id)

    response = Plan::Update
      .call(account_id: account.id, plan_id: plan.id, name: "New plan name")

    assert response.success?
    assert_equal "New plan name", response.value.name
  end
end

# frozen_string_literal: true

require "test_helper"

class Plan::CreateTest < ActiveSupport::TestCase
  test "plan creation with the proper values" do
    account = Factory.generate_account

    response = Plan::Create
      .call(account_id: account.id, name: "My first plan")

    assert response.success?
  end

  test "plan creation fails when account is missing" do
    response = Plan::Create
      .call(name: "My first plan")

    assert response.failure?
    assert response.value.data.errors[:account_id].present?
  end

  test "plan creation fails when name is missing" do
    account = Factory.generate_account

    response = Plan::Create
      .call(account_id: account.id)

    assert response.failure?
    assert response.value.data.errors[:name].present?
  end
end

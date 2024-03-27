# frozen_string_literal: true

require "test_helper"

class Event::CreateTest < ActiveSupport::TestCase
  test "event creation with the proper values" do
    plan = Factory.generate_plan
    picto = Factory.generate_picto

    response = Event::Create
      .call(plan_id: plan.id, picto_id: picto.id, title: "Event", day_of_the_week: 0)

    assert response.success?
  end
end

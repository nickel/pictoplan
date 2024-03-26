# frozen_string_literal: true

require "test_helper"

class Picto::CreateTest < ActiveSupport::TestCase
  test "picto creation with the proper values" do
    response = Picto::Create
      .call(keyword: "Foo", external_id: "1", external_source: "source")

    assert response.success?
  end
end

# frozen_string_literal: true

require "test_helper"

class Picto::EnableTest < ActiveSupport::TestCase
  test "picto should be enabled" do
    picto = Factory.generate_picto(enabled: false)

    refute picto.enabled?

    response = Picto::Enable.call(picto_id: picto.id)

    assert response.success?
    assert response.value.enabled?
  end
end

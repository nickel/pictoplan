# frozen_string_literal: true

require "test_helper"

class Picto::DisableTest < ActiveSupport::TestCase
  test "picto should be disabled" do
    picto = Factory.generate_picto(enabled: true)

    assert picto.enabled?

    response = Picto::Disable.call(picto_id: picto.id)

    assert response.success?
    refute response.value.enabled?
  end
end

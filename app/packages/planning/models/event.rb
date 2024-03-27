# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :plan
  belongs_to :picto

  def to_struct
    CustomStruct
      .new(attributes)
  end
end

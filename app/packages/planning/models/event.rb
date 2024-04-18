# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :plan
  belongs_to :picto

  acts_as_list scope: %i(plan_id day_of_the_week)

  def to_struct
    CustomStruct
      .new(attributes)
  end
end

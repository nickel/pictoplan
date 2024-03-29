# frozen_string_literal: true

class Plan < ApplicationRecord
  belongs_to :account

  def to_struct
    CustomStruct
      .new(attributes.merge(active?: active))
  end
end

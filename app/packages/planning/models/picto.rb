# frozen_string_literal: true

class Picto < ApplicationRecord
  has_one_attached :image

  def to_struct
    CustomStruct.new(attributes)
  end
end

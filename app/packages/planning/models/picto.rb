# frozen_string_literal: true

class Picto < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [160, 160]
    attachable.variant :mini_thumb, resize_to_limit: [100, 100]
  end

  def to_struct
    CustomStruct.new(
      attributes.merge(enabled?: enabled, image:)
    )
  end
end

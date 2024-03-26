# frozen_string_literal: true

class Picto::Create < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :keyword, :string
    attribute :external_id, :integer
    attribute :external_source, :string
    attribute :active, :boolean

    attribute :image
    attribute :data
  end

  delegate(*Form.new.attributes.keys, to: :form)

  def call
    Picto
      .new(keyword:, external_id:, external_source:, active:, data:)
      .save_with_response
      .and_then do |picto|
        picto.image.attach(io: File.open(image), filename: "image.png") if image

        Response.success(picto.to_struct)
      end
  end
end

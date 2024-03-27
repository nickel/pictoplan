# frozen_string_literal: true

class Picto::Disable < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :picto_id, :integer
  end

  delegate(*Form.new.attributes.keys, to: :form)

  def call
    Picto::Find
      .call(picto_id:)
      .and_then do
        Picto
          .find_by(id: picto_id)
          .update_with_response(enabled: false)
          .and_then do |picto|
            Response.success(picto.to_struct)
          end
      end
  end
end

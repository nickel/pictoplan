# frozen_string_literal: true

class Picto::Find < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :picto_id, :integer
  end

  delegate(*Form.new.attributes.keys, to: :form)

  def call
    if (picto = Picto.find_by(id: picto_id))
      Response.success(picto.to_struct)
    else
      Response.failure(
        Errors::RecordNotFoundError
          .build(form:)
      )
    end
  end
end

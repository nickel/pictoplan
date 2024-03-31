# frozen_string_literal: true

class Event::Find < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :plan_id, :integer
    attribute :event_id, :integer
  end

  delegate(*Form.new.attributes.keys, to: :form)

  def call
    if (event = Event.find_by(plan_id:, id: event_id))
      Response.success(event.to_struct)
    else
      Response.failure(
        Errors::RecordNotFoundError
          .build(form:)
      )
    end
  end
end

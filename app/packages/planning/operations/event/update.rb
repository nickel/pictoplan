# frozen_string_literal: true

class Event::Update < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :plan_id, :integer
    attribute :event_id, :integer
    attribute :picto_id, :integer
    attribute :title, :string
    attribute :day_of_the_week, :integer
  end

  delegate(*Form.new.attributes.keys, to: :form)

  def call
    Event::Find
      .call(plan_id:, event_id:)
      .and_then do
        Event
          .find_by(id: event_id)
          .update_with_response(picto_id:, title:, day_of_the_week:)
          .and_then do |event|
            Response.success(event.to_struct)
          end
      end
  end
end

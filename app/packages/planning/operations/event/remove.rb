# frozen_string_literal: true

class Event::Remove < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :plan_id, :integer
    attribute :event_id, :integer

    validates :plan_id, presence: true
    validates :event_id, presence: true
  end

  delegate :event_id, :plan_id, to: :form

  def execute
    Event::Find
      .call(plan_id:, event_id:)
      .and_then do |event|
        Response.success(
          Event
            .destroy(event.id)
            .to_struct
        )
      end
  end
end

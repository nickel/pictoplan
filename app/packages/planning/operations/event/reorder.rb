# frozen_string_literal: true

class Event::Reorder < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :plan_id, :integer
    attribute :event_id, :integer
    attribute :position, :integer

    validates :plan_id, presence: true
    validates :event_id, presence: true
    validates :position, presence: true
  end

  delegate :plan_id, :event_id, :position, to: :form

  def execute
    Event::Find
      .call(plan_id:, event_id:)
      .and_then do |_event|
        Response.success(
          Event
            .find(event_id)
            .insert_at(position)
        )
      end
  end
end

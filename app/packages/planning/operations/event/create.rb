# frozen_string_literal: true

class Event::Create < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :plan_id, :integer
    attribute :picto_id, :integer
    attribute :title, :string
    attribute :day_of_the_week, :integer
  end

  delegate(*Form.new.attributes.keys, to: :form)

  def call
    Event
      .new(plan_id:, picto_id:, title:, day_of_the_week:)
      .save_with_response
      .and_then do |event|
        Response.success(event.to_struct)
      end
  end
end

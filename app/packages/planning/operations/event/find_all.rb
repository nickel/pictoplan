# frozen_string_literal: true

class Event::FindAll < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :plan_id, :integer

    validates :plan_id, presence: true
  end

  delegate(*Form.new.attributes.keys, to: :form)

  def execute
    Response.success(
      Event
        .where(plan_id:)
        .order(:day_of_the_week)
    )
  end
end

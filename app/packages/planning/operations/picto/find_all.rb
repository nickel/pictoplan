# frozen_string_literal: true

class Picto::FindAll < CommandHandler::Command
  class Form
    include CommandHandler::Form

    attribute :keyword, :string
    attribute :enabled, :boolean, default: false
    attribute :page, :integer
    attribute :per_page, :integer, default: 25
  end

  delegate(*Form.new.attributes.keys, to: :form)

  def call
    pictos = find_all

    Response.success(
      PaginatedCollection.new(
        pictos.map(&:to_struct),
        pictos.current_page,
        pictos.prev_page,
        pictos.next_page,
        pictos.total_pages,
        per_page
      )
    )
  end

  private

  def find_all
    pictos = Picto.all
    pictos = pictos.where("keyword ILIKE ?", "%#{keyword}%") if keyword.present?

    pictos
      .where(enabled:)
      .order(:keyword)
      .page(page)
      .per(per_page)
  end
end

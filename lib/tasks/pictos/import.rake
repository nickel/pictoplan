# frozen_string_literal: true

namespace :pictos do
  desc "Import pictos"
  task import: :environment do
    Dir.foreach(Rails.root.join("vendor/pictos")) do |filename|
      next if [".", ".."].include?(filename)

      data = JSON.parse(File.read(Rails.root.join("vendor/pictos", filename, "data.json")))
      image = Rails.root.join("vendor/pictos", filename, "image.png")

      keyword = data["keywords"].first["keyword"]
      external_id = data["_id"]
      external_source = "arasaac"

      next if Picto.exists?(external_id:, external_source:)

      Picto::Create.call(keyword:, external_id:, external_source:, active: false, image:, data:)
    rescue StandardError
      next
    end
  end
end

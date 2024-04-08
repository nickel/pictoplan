# frozen_string_literal: true

namespace :pictos do
  desc "Local import pictos"
  task local_import: :environment do
    Dir.foreach(Rails.root.join("vendor/pictos")) do |filename|
      next if [".", ".."].include?(filename)

      data = JSON.parse(File.read(Rails.root.join("vendor/pictos", filename, "data.json")))
      image = Rails.root.join("vendor/pictos", filename, "image.png")

      keyword = data["keywords"].first["keyword"]
      external_id = data["_id"]
      external_source = "arasaac"

      next if Picto.exists?(external_id:, external_source:)

      Picto::Create.call(keyword:, external_id:, external_source:, enabled: false, image:, data:)
    rescue StandardError
      next
    end
  end

  desc "Remove import pictos"
  task remote_import: :environment do
    require "open-uri"

    pictograms = ApiClients::Arasaac
      .new
      .all_pictograms

    pictograms.each do |picto|
      external_id = picto.id
      external_source = "arasaac"

      next if Picto.exists?(external_id:, external_source:)

      image = URI.parse(picto.image_location).open

      Picto::Create.call(
        external_id:,
        external_source:,
        image:,
        keyword: picto.keyword,
        data: picto.data,
        enabled: false
      )

      puts "Picto ##{external_id}: #{picto.keyword}"
    end
  end
end

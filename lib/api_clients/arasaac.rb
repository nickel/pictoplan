# frozen_string_literal: true

module ApiClients
  class Arasaac
    BASE_URL = "https://api.arasaac.org"

    def all_pictograms
      connection.get("/v1/pictograms/all/es").body.map do |picto|
        id = picto["_id"]

        CustomStruct.new(
          id:,
          keyword: picto["keywords"].first["keyword"],
          data: picto,
          image_location: "https://static.arasaac.org/pictograms/#{id}/#{id}_2500.png"
        )
      end
    end

    def agent
      @agent ||= Faraday.new(url: BASE_URL) do |builder|
        builder.response :json
      end
    end

    alias connection agent

    delegate :get, :post, :put, :delete, :head, :patch, :options, :trace,
             :connect, :headers, :in_parallel, :in_parallel?, to: :agent
  end
end

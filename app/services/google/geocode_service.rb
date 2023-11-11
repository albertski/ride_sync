# frozen_string_literal: true

module Google
  class GeocodeService
    API_URL = 'https://maps.googleapis.com/maps/api/geocode/json'

    attr_reader :address

    def self.lookup(address:)
      new(address).lookup
    end

    def initialize(address)
      @address = address
    end

    def lookup
      return if address.blank?

      response = Net::HTTP.get(URI(full_url))
      result = JSON.parse(response)
      if result['status'] == 'OK'
        location = result['results'][0]['geometry']['location']
        { latitude: location['lat'], longitude: location['lng'] }
      else
        { latitude: nil, longitude: nil }
      end
    end

    private

    def params
      {
        address:,
        key: ENV['GOOGLE_API_KEY']
      }
    end

    def full_url
      "#{API_URL}?#{URI.encode_www_form(params)}"
    end
  end
end

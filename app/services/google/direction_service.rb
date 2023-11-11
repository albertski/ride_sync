# frozen_string_literal: true

module Google
  class DirectionService
    API_URL = 'https://maps.googleapis.com/maps/api/directions/json'

    attr_reader :destination, :origin

    def self.lookup(destination:, origin:)
      new(destination, origin).lookup
    end

    def initialize(destination, origin)
      @destination = destination
      @origin = origin
    end

    def lookup
      return if destination.blank? || origin.blank?

      response = Net::HTTP.get(URI(full_url))
      result = JSON.parse(response)
      legs_result(result['routes'][0]['legs'][0]) if result['status'] == 'OK'
    end

    private

    def legs_result(legs)
      {
        distance: legs['distance']['value'],
        duration: legs['duration']['value']
      }
    end

    def params
      {
        destination:,
        origin:,
        key: ENV['GOOGLE_API_KEY']
      }
    end

    def full_url
      "#{API_URL}?#{URI.encode_www_form(params)}"
    end
  end
end

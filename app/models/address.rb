# frozen_string_literal: true

class Address < ApplicationRecord
  has_many :start_rides, class_name: 'Ride', foreign_key: :start_address_id
  has_many :destination_rides, class_name: 'Ride', foreign_key: :destination_address_id
  has_many :driver_home_addresses, class_name: 'Driver', foreign_key: :home_address_id

  validates :address1, :city, :state, :zip_code, :country, presence: true
  validates_uniqueness_of :address1, scope: [:address2, :city, :state, :zip_code, :country]

  before_save :set_coordinates, if: :geocode_address

  attr_accessor :geocode_address

  private

  def set_coordinates
    geolocation = Google::GeocodeService.lookup(address: full_address)

    return unless geolocation[:latitude] && geolocation[:longitude]

    self.latitude = geolocation[:latitude]
    self.longitude = geolocation[:longitude]
  end

  def full_address
    "#{address1} #{address2}, #{city}, #{state}, #{zip_code}, #{country}"
  end
end

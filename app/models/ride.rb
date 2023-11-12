# frozen_string_literal: true

class Ride < ApplicationRecord
  belongs_to :start_address, class_name: 'Address'
  belongs_to :destination_address, class_name: 'Address'

  validates_uniqueness_of :start_address, scope: [:destination_address]
  validates :start_address, :destination_address, presence: true

  scope :within_distance, lambda { |latitude, longitude, distance = 100|
    where(
      '6371.0 * acos(cos(radians(?)) * cos(radians(addresses.latitude)) * cos(radians(addresses.longitude) - '\
      'radians(?)) + sin(radians(?)) * sin(radians(addresses.latitude))) <= ?',
      latitude,
      longitude,
      latitude,
      distance
    ).joins(:start_address)
  }

  attr_reader :driver_details

  def driver_details=(driver)
    @driver_details = RideDriverDetails.new(self, driver)
  end
end

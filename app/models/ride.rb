# frozen_string_literal: true

class Ride < ApplicationRecord
  belongs_to :start_address, class_name: 'Address'
  belongs_to :destination_address, class_name: 'Address'

  validates_uniqueness_of :start_address, scope: [:destination_address]
  validates :start_address, :destination_address, presence: true

  scope :within_distance, lambda { |latitude, longitude, distance|
    where(
      '3959 * 2 * ASIN(SQRT(SIN((? * PI() / 180 - addresses.latitude * PI() / 180) / 2) ^ 2 + COS(? * PI() / 180) * '\
      'COS(addresses.latitude * PI() / 180) * SIN((? * PI() / 180 - addresses.longitude * PI() / 180) / 2) ^ 2)) <= ?',
      latitude,
      latitude,
      longitude,
      distance
    ).joins(:start_address)
  }

  attr_reader :driver_details

  def driver_details=(driver)
    @driver_details = RideDriverDetails.new(self, driver)
  end
end

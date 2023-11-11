# frozen_string_literal: true

class Ride < ApplicationRecord
  belongs_to :start_address, class_name: 'Address'
  belongs_to :destination_address, class_name: 'Address'

  validates_uniqueness_of :start_address, scope: [:destination_address]
  validates :start_address, :destination_address, presence: true

  attr_reader :driver_details

  def driver_details=(driver)
    @driver_details = RideDriverDetails.new(self, driver)
  end
end

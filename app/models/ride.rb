# frozen_string_literal: true

class Ride < ApplicationRecord
  belongs_to :start_address, class_name: 'Address'
  belongs_to :destination_address, class_name: 'Address'

  validates_uniqueness_of :start_address, scope: [:destination_address]
  validates :start_address, :destination_address, presence: true
end

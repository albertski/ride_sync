# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DriverRidesService do
  describe 'fetch' do
    subject { described_class.fetch(driver, 100) }

    let(:driver) { create(:driver) }
    let!(:rides) { create_list(:ride, 3) }

    before do
      allow(Ride).to receive(:within_distance)
        .with(driver.home_address.latitude, driver.home_address.longitude, 100).and_return(rides)
      set_mock_for_ride_driver_details(rides[0], driver, 22)
      set_mock_for_ride_driver_details(rides[1], driver, 101)
      set_mock_for_ride_driver_details(rides[2], driver, 42)
    end

    it 'returns rides sorted by score in descending order' do
      expect(subject).to eq([rides[1], rides[2], rides[0]])
    end
  end

  def set_mock_for_ride_driver_details(ride, driver, score)
    ride_driver_details = double('RideDriverDetails')
    allow(ride_driver_details).to receive(:score).and_return(score)
    allow(RideDriverDetails).to receive(:new).with(ride, driver).and_return(ride_driver_details)
  end
end

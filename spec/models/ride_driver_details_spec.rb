# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RideDriverDetails, type: :model do
  subject { described_class.new(ride, driver) }

  let(:ride)   { create(:ride) }
  let(:driver) { create(:driver) }

  before do
    allow(Google::DirectionService).to receive(:lookup)
      .with(destination: ride.destination_address.full_address, origin: ride.start_address.full_address)
      .and_return({ distance: 2000, duration: 7200 })
    allow(Google::DirectionService).to receive(:lookup)
      .with(destination: ride.start_address.full_address, origin: driver.home_address.full_address)
      .and_return({ distance: 4000, duration: 1800 })
    allow(Google::DirectionService).to receive(:lookup)
      .with(destination: ride.destination_address.full_address, origin: driver.home_address.full_address)
      .and_return({ distance: 4000, duration: 1800 })
  end

  describe '#driving_distance' do
    it 'returns the calculated istance between the ride start and destination address in miles' do
      expect(subject.driving_distance).to eq(1.242742)
    end
  end

  describe '#driving_duration' do
    it 'returns the amount in time it would take to drive from ride start and destination address in hours' do
      expect(subject.driving_duration).to eq(2)
    end
  end

  describe '#commute_distance' do
    it "returns the calculated distance between the driver's home address and the ride start address in miles" do
      expect(subject.commute_distance).to eq(2.485484)
    end
  end

  describe '#commute_duration' do
    it "returns the amount in time it would take to drive from the driver's home address and the ride start address "\
       'in hours' do
      expect(subject.commute_duration).to eq(0.5)
    end
  end

  describe '#ride_distance' do
    it "returns the calculated distance between the driver's home address and the ride destination address in miles" do
      expect(subject.ride_distance).to eq(2.485484)
    end
  end

  describe '#ride_duration' do
    it "returns the amount in time it would take to drive from the driver's home address and the ride destination "\
       'address in hours' do
      expect(subject.ride_duration).to eq(0.5)
    end
  end

  describe '#ride_earnings' do
    it 'returns calculated earnings with the following logic: $12 + $1.50 per mile beyond 5 miles + '\
       '(ride duration) * $0.70 per minute beyond 15 minutes' do
      expect(subject.ride_earnings).to eq(22.5)
    end
  end

  describe '#score' do
    it 'returns calculated score using the following logic: (ride earnings) / (commute duration + ride duration)' do
      expect(subject.score).to eq(22.5)
    end
  end
end

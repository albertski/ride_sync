# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe 'associations' do
    it { should belong_to(:start_address).class_name('Address') }
    it { should belong_to(:destination_address).class_name('Address') }
  end

  describe 'validations' do
    it { should validate_presence_of(:start_address) }
    it { should validate_presence_of(:destination_address) }
  end

  describe '#driver_details' do
    subject { build(:ride) }

    let(:driver) { create(:driver) }

    before do
      ride_driver_details = double('RideDriverDetails')
      allow(ride_driver_details).to receive(:score).and_return(10)
      allow(RideDriverDetails).to receive(:new).with(subject, driver).and_return(ride_driver_details)
    end

    context 'when driver details is not set' do
      it { expect(subject.driver_details).to be_nil }
    end

    context 'when driver details is set' do
      it 'allows you to access driver_details items' do
        subject.driver_details = driver

        expect(subject.driver_details.score).to eq(10)
      end
    end
  end

  describe '.within_distance' do
    let!(:ride1) { create(:ride, start_address: create(:address, latitude: 41.9512089, longitude: -87.6496156)) }
    let!(:ride2) { create(:ride, start_address: create(:address, latitude: 34.1035462, longitude: -118.18016)) }
    let!(:ride3) { create(:ride, start_address: create(:address, latitude: 41.9487195, longitude: -87.6442041)) }

    context 'when user is in Chicago' do
      context 'when search for rides within 100 miles' do
        subject { described_class.within_distance(41.6350629, -87.9305407, 100) }

        it 'should not include rides from California' do
          expect(subject).to match_array([ride1, ride3])
        end
      end
    end

    context 'when user is in Chicago' do
      context 'when search for rides within 4000 miles' do
        subject { described_class.within_distance(41.6350629, -87.9305407, 4000) }

        it 'should include rides from California' do
          expect(subject).to match_array([ride1, ride2, ride3])
        end
      end
    end
  end
end

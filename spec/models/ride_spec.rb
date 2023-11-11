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
end

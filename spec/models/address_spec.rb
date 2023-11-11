# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'associations' do
    it { should have_many(:start_rides).class_name('Ride') }
    it { should have_many(:destination_rides).class_name('Ride') }
    it { should have_many(:driver_home_addresses).class_name('Driver') }
  end

  describe 'validations' do
    it { should validate_presence_of(:address1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:country) }
  end

  describe 'geocoding' do
    before do
      allow(Google::GeocodeService).to receive(:lookup).with(address: full_address)
                                                       .and_return(latitude: 1.0, longitude: 2.0)
    end

    let(:full_address) do
      "#{address.address1} #{address.address2}, #{address.city}, #{address.state}, "\
      "#{address.zip_code}, #{address.country}"
    end

    context 'when geocode_address is set to true' do
      let(:address) { build(:address, geocode_address: true) }

      context 'when saving' do
        it 'updates latitude and longitude' do
          address.save

          expect(address.latitude).to eq(1.0)
          expect(address.longitude).to eq(2.0)
        end
      end

      context 'when updating' do
        let(:address) { create(:address) }

        it 'updates latitude and longitude' do
          address.update(geocode_address: true)

          expect(address.reload.latitude).to eq(1.0)
          expect(address.reload.longitude).to eq(2.0)
        end
      end
    end

    context 'when geocode_address is not set to true' do
      let(:address) { build(:address) }

      context 'when saving' do
        it 'does not update latitude and longitude' do
          address.save

          expect(Google::GeocodeService).not_to have_received(:lookup)
        end
      end

      context 'when updating' do
        let(:address) { create(:address) }

        it 'updates latitude and longitude' do
          address.update(state: 'IL')

          expect(Google::GeocodeService).not_to have_received(:lookup)
        end
      end
    end
  end
end

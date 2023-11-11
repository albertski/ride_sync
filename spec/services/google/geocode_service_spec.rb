# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Google::GeocodeService do
  describe '.lookup' do
    subject { described_class.lookup(address:) }

    let(:api_key) { 'my_api_key' }
    let(:address) { '742 Evergreen Terrace, Springfield, USA' }

    before do
      allow(ENV).to receive(:[]).with('GOOGLE_API_KEY').and_return(api_key)

      stub_request(:get, /#{described_class::API_URL}/)
        .with(query: hash_including(address:, key: api_key))
        .to_return(
          status: 200,
          body: response
        )
    end

    context 'when valid address is sent' do
      let(:response) { file_fixture('google/geocode_valid_response.json').read }

      it 'returns the latitude and longitude' do
        expect(subject).to eq({ latitude: 37.4224764, longitude: -122.0842499 })
      end
    end

    context 'when invalid address is sent' do
      let(:response) { file_fixture('google/geocode_invalid_response.json').read }

      it 'returns null latitude and longitude' do
        expect(subject).to eq({ latitude: nil, longitude: nil })
      end
    end
  end
end

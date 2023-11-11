# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Google::DirectionService do
  describe '.lookup' do
    subject { described_class.lookup(destination:, origin:) }

    let(:api_key)     { 'my_api_key' }
    let(:destination) { '742 Evergreen Terrace, Springfield, USA' }
    let(:origin)      { '0001 Cemetery Lane, USA' }

    before do
      allow(ENV).to receive(:[]).with('GOOGLE_API_KEY').and_return(api_key)
      allow(Rails.cache).to receive(:fetch).and_return(nil)

      stub_request(:get, /#{described_class::API_URL}/)
        .with(query: hash_including(destination:, origin:, key: api_key))
        .to_return(
          status: 200,
          body: response
        )
    end

    context 'when valid destination and origin is sent' do
      let(:response) { file_fixture('google/direction_valid_response.json').read }

      it 'returns the latitude and longitude' do
        expect(Rails.cache).to receive(:fetch).once.and_call_original
        expect(subject).to eq({ distance: 2943, duration: 357 })
      end
    end

    context 'when invalid destination and origin is sent' do
      let(:response) { file_fixture('google/geocode_invalid_response.json').read }

      it 'returns null' do
        expect(Rails.cache).to receive(:fetch).once.and_call_original
        expect(subject).to eq(nil)
      end
    end
  end
end

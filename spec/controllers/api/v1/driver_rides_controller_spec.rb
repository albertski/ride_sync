# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DriverRidesController, type: :controller do
  describe 'GET #index' do
    let(:driver) { create(:driver) }

    context 'with valid parameters' do
      before do
        get :index, params: { driver: driver.id, page: 1, distance: 100 }, format: :json
      end

      it 'responds with success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns @driver_rides' do
        expect(controller.instance_variable_get(:@driver_rides)).to be_a(Kaminari::PaginatableArray)
      end

      it 'returns JSON content' do
        expect(response.content_type).to include('application/json')
      end
    end

    context 'with invalid driver' do
      before do
        get :index, params: { driver: 'invalid_id', page: 1, distance: 100 }, format: :json
      end

      it 'responds with not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message in JSON' do
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Driver not found' })
      end
    end
  end
end

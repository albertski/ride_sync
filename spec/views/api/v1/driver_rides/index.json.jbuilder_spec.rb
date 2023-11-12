# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/v1/driver_rides/index.json.jbuilder', type: :view do
  let(:rides)  { create_list(:ride, 1) }
  let(:driver) { create(:driver) }

  before do
    ride_driver_details = double('RideDriverDetails')
    allow(ride_driver_details).to receive(:score).and_return(10)
    allow(RideDriverDetails).to receive(:new).with(rides[0], driver).and_return(ride_driver_details)
    rides[0].driver_details = driver
    assign(:driver_rides, Kaminari.paginate_array(rides).page(1).per(5))
    render
  end

  it 'renders JSON with the correct structure' do
    json = JSON.parse(rendered)

    expect(json).to be_a(Hash)
    expect(json['data']).to be_an(Array)
    expect(json['count']).to eq(1)
    expect(json['total_pages']).to eq(1)
    expect(json['current_page']).to eq(1)
    expect(json['links']).to be_a(Hash)
    expect(json['links']['self']).to eq('/api/v1/driver_rides')
    expect(json['links']['prev']).to be_nil
    expect(json['links']['next']).to be_nil
  end
end

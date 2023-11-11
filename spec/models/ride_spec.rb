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
end

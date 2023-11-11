# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Driver, type: :model do
  describe 'associations' do
    it { should belong_to(:home_address).class_name('Address') }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:home_address) }
  end
end

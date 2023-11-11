# frozen_string_literal: true

FactoryBot.define do
  factory :ride do
    start_address       { create(:address) }
    destination_address { create(:address) }
  end
end

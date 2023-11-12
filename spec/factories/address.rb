# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    address1   { Faker::Address::street_address }
    address2   { Faker::Address::street_address }
    city       { Faker::Address.city }
    state      { Faker::Address.state }
    zip_code   { Faker::Address.zip_code }
    country    { Faker::Address.country }
  end
end

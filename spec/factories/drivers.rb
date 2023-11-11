FactoryBot.define do
  factory :driver do
    first_name   { "MyString" }
    last_name    { "MyString" }
    home_address { create(:address) }
  end
end

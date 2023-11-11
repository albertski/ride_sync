# frozen_string_literal: true

class Driver < ApplicationRecord
  belongs_to :home_address, class_name: 'Address',  foreign_key: :home_address_id
  validates :first_name, :last_name, :home_address, presence: true, uniqueness: true
end

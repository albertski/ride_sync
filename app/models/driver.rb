class Driver < ApplicationRecord
  belongs_to :home_address, class_name: 'Address'
  validates :first_name, :last_name, :home_address, presence: true
  validates_uniqueness_of :first_name, scope: [:last_name, :home_address]
end

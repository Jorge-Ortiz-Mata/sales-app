class Customer < ApplicationRecord
  validates :full_name
  validates :phone_number
  validates :address
end

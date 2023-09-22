class Customer < ApplicationRecord
  validates :full_name, :phone_number, :address, presence: true
end

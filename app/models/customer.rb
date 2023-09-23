class Customer < ApplicationRecord
  validates :full_name, :phone_number, :address, presence: true
  validates :phone_number, length: { maximum: 10 }
  validates :phone_number, numericality: { only_integer: true, message: 'debe tener solo números' }
end

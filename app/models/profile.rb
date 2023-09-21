class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar, dependent: :destroy

  validates :first_name, :last_name, :phone_number, presence: true, on: :update
  validates :phone_number, length: { maximum: 10 }, on: :update
  validates :phone_number, numericality: { only_integer: true, message: 'debe tener solo números' }, on: :update

  def full_name
    return '--' unless first_name && last_name

    "#{first_name} #{last_name}"
  end
end

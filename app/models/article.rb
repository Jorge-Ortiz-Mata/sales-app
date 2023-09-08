class Article < ApplicationRecord
  validates :name, :description, :price, :in_stock, presence: true
  validates :name, uniqueness: true
  validates :price, comparison: { greater_than_or_equal_to: 0 }
  validates :in_stock, comparison: { greater_than: 0 }

  has_one_attached :avatar
  has_many_attached :images

  has_rich_text :description
  has_many :sells, dependent: :destroy
  has_and_belongs_to_many :categories
end

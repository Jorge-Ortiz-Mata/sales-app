class Article < ApplicationRecord
  validates :name, :description, :price, :in_stock, presence: true
  validates :name, uniqueness: true

  has_rich_text :description
  has_and_belongs_to_many :categories
end

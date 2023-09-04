class Article < ApplicationRecord
  validates :name, :description, :price, :in_stock, presence: true
  validates :name, uniqueness: true

  has_rich_text :description
end

class Article < ApplicationRecord
  validates :name, :description, :price, :in_stock, presence: true

  has_rich_text :description
end

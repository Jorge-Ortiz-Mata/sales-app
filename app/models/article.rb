class Article < ApplicationRecord
  scope :available_in_stock, -> { where('in_stock > 0') }
  scope :with_min_price, ->(articles, min_price) { articles.where('price > ?', min_price) }
  scope :with_max_price, ->(articles, max_price) { articles.where('price < ?', max_price) }

  validates :name, :description, :price, :in_stock, presence: true
  validates :name, uniqueness: true
  validates :price, comparison: { greater_than_or_equal_to: 0 }
  validates :in_stock, comparison: { greater_than_or_equal_to: 0 }
  validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif']
  validates :promotional_video, content_type: ['video/mp4', 'video/webm']

  has_one_attached :avatar
  has_one_attached :promotional_video
  has_many_attached :images

  has_rich_text :description
  has_many :sells, dependent: :destroy
  has_and_belongs_to_many :categories

  def name_with_in_stock
    "#{name} (#{in_stock} pz disp)"
  end
end

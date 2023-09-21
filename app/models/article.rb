class Article < ApplicationRecord
  scope :search_with_name, ->(name) { where("name LIKE '%#{name}%'") }
  scope :with_min_price, ->(articles, min_price) { articles.where('price > ?', min_price) }
  scope :with_max_price, ->(articles, max_price) { articles.where('price < ?', max_price) }

  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates :price, comparison: { greater_than_or_equal_to: 0 }
  validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif']
  validates :promotional_video, content_type: ['video/mp4', 'video/webm']

  has_one_attached :avatar
  has_one_attached :promotional_video
  has_many_attached :images

  has_rich_text :description

  has_many :article_sells
  has_many :sells, through: :article_sells
  has_and_belongs_to_many :categories

  before_destroy :delete_articles_associations

  private

  def delete_articles_associations
    ArticleSell.where(article_id: id).delete_all
  end
end

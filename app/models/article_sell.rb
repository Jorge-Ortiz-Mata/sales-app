class ArticleSell < ApplicationRecord
  scope :calculate_articles_quantity, ->(id) { where(article_id: id).sum(:quantity) }

  belongs_to :article
  belongs_to :sell

  validates :article_id, :quantity, presence: true
  validates :quantity, comparison: { greater_than_or_equal_to: 0 }
  validate :article_exists?

  before_save :set_revenue

  private

  def article_exists?
    errors.add(:article_id, :article_does_not_exist) unless Article.find_by(id: article_id).present?
  end

  def set_revenue
    article = Article.find(article_id)

    self.revenue = quantity.to_d * article.price.to_d
  end
end

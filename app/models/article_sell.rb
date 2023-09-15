class ArticleSell < ApplicationRecord
  belongs_to :article
  belongs_to :sell

  validates :article_id, :quantity, presence: true
  validates :quantity, comparison: { greater_than_or_equal_to: 0 }
  validate :article_exists?
  validate :availability_in_stock, on: :create

  after_create :decrease_in_stock_article
  before_save :set_revenue

  private

  def article_exists?
    errors.add(:article_id, :article_does_not_exist) unless Article.find_by(id: article_id).present?
  end

  def availability_in_stock
    return unless Article.find_by(id: article_id).present?

    errors.add(:quantity, :insufficient_articles) if quantity > Article.find_by(id: article_id).in_stock
  end

  def decrease_in_stock_article
    current_stock = article.in_stock

    article.update!(in_stock: current_stock - quantity)
  end

  def set_revenue
    article = Article.find(article_id)

    self.revenue = quantity.to_d * article.price.to_d
  end
end

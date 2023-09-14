class ArticleSell < ApplicationRecord
  belongs_to :article
  belongs_to :sell

  validates :quantity, presence: true

  # validate :availability_in_stock, on: :create

  # after_create :decrease_in_stock_article
  # before_save :set_total_revenue

  private

  # def availability_in_stock
  #   return unless article && quantity

  #   errors.add(:quantity, :insufficient_articles) if quantity > article.in_stock
  # end

  # def decrease_in_stock_article
  #   current_stock = article.in_stock

  #   article.update!(in_stock: current_stock - quantity)
  # end

  # def set_total_revenue
  #   self.total_revenue = quantity.to_d * article.price.to_d
  # end
end

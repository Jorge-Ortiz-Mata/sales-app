class Sell < ApplicationRecord
  belongs_to :article, optional: true

  validates :quantity, :day, :date_of_sell, :article, presence: true
  validate :format_day
  validate :availability_in_stock

  after_create :decrease_in_stock_article

  DAYS = %w[LUNES MARTES MIERCOLES JUEVES VIERNES SABADO DOMINGO].freeze

  def total_revenue
    quantity * article.price
  end

  private

  def format_day
    return if DAYS.include?(day)

    errors.add(:day, :invalid_day)
  end

  def availability_in_stock
    return unless article && quantity

    errors.add(:quantity, :insufficient_articles) if quantity > article.in_stock
  end

  def decrease_in_stock_article
    current_stock = article.in_stock

    article.update!(in_stock: current_stock - quantity)
  end
end

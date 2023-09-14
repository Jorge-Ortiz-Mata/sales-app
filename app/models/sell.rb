class Sell < ApplicationRecord
  belongs_to :article, counter_cache: true

  validates :quantity, :date_of_sell, :article, presence: true
  validate :availability_in_stock, on: :create

  after_create :decrease_in_stock_article
  before_save :set_total_revenue

  def self.latest_sells
    data = []
    seven_days_from_today = [Date.today]

    for i in 1..30
      prev_day = Date.today - i.day
      seven_days_from_today << prev_day
    end

    seven_days_from_today.each do |day|
      revenue_day = Sell.where(date_of_sell: day).sum(:total_revenue)
      data << [day, revenue_day]
    end

    data
  end

  private

  def availability_in_stock
    return unless article && quantity

    errors.add(:quantity, :insufficient_articles) if quantity > article.in_stock
  end

  def decrease_in_stock_article
    current_stock = article.in_stock

    article.update!(in_stock: current_stock - quantity)
  end

  def set_total_revenue
    self.total_revenue = quantity.to_d * article.price.to_d
  end
end

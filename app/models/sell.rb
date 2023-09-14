class Sell < ApplicationRecord
  scope :filter_with_date_min, ->(sells, date_min) { sells.where('date_of_sell >= ?', date_min) }
  scope :filter_with_date_max, ->(sells, date_max) { sells.where('date_of_sell <= ?', date_max) }

  belongs_to :article, counter_cache: true

  validates :quantity, :date_of_sell, :article, presence: true
  validate :availability_in_stock, on: :create

  after_create :decrease_in_stock_article
  before_save :set_total_revenue

  def self.latest_sells
    data = []
    thirty_days_from_today = [Date.today]

    for i in 1..30
      prev_day = Date.today - i.day
      thirty_days_from_today << prev_day
    end

    thirty_days_from_today.each do |day|
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

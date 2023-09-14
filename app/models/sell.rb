class Sell < ApplicationRecord
  scope :filter_with_date_min, ->(sells, date_min) { sells.where('date_of_sell >= ?', date_min) }
  scope :filter_with_date_max, ->(sells, date_max) { sells.where('date_of_sell <= ?', date_max) }

  validates :date_of_sell, presence: true

  has_many :article_sells
  has_many :articles, through: :article_sells

  def self.latest_sells
    # data = []
    # thirty_days_from_today = [Date.today]

    # for i in 1..30
    #   prev_day = Date.today - i.day
    #   thirty_days_from_today << prev_day
    # end

    # thirty_days_from_today.each do |day|
    #   revenue_day = Sell.where(date_of_sell: day).sum(:total_revenue)
    #   data << [day, revenue_day]
    # end

    [Date.today, 10]
  end
end

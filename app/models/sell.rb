class Sell < ApplicationRecord
  scope :filter_with_date_min, ->(sells, date_min) { sells.where('date_of_sell >= ?', date_min) }
  scope :filter_with_date_max, ->(sells, date_max) { sells.where('date_of_sell <= ?', date_max) }

  validates :date_of_sell, presence: true
  validate :date_of_sell_less_than_today

  has_many :article_sells
  has_many :articles, through: :article_sells

  before_destroy :delete_articles_associations

  def self.revenue_by_day
    data = []

    for i in 0...30
      day_total_revenue = 0
      from_date = Date.today - i.day

      sells = Sell.where(date_of_sell: from_date)

      sells.each do |sell|
        sell_revenue = sell.article_sells.sum(:revenue)
        day_total_revenue += sell_revenue
      end

      data << [from_date, day_total_revenue]
    end

    data
  end

  private

  def date_of_sell_less_than_today
    return unless date_of_sell.present?

    errors.add(:date_of_sell, :greater_than_today) if date_of_sell.to_date > Date.today
  end

  def delete_articles_associations
    ArticleSell.where(sell_id: id).delete_all
  end
end

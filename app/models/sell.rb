class Sell < ApplicationRecord
  scope :filter_with_date_min, ->(sells, date_min) { sells.where('date_of_sell >= ?', date_min) }
  scope :filter_with_date_max, ->(sells, date_max) { sells.where('date_of_sell <= ?', date_max) }

  validates :date_of_sell, presence: true
  validate :date_of_sell_less_than_today

  has_many :article_sells
  has_many :articles, through: :article_sells

  before_destroy :delete_articles_associations

  def self.latest_sells
    data = []
    thirty_days_from_today = [Date.today]

    Array.new(30).each_with_index do |_, i|
      thirty_days_from_today << Date.today - i.day
    end

    thirty_days_from_today.each do |day|
      sells = Sell.where(date_of_sell: day)
      total_revenue = 0

      sells.each { |sell| total_revenue += sell.article_sells.sum(:revenue) }

      data << [day, total_revenue]
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

class SellsFilter
  include ActiveModel::Model

  attr_accessor :article_id, :date_min, :date_max

  validate :article_exists
  validate :date_min_less_than_date_max
  validate :date_max_equal_today_date

  define_model_callbacks :save
  before_save :format_dates

  def save
    self.date_min = date_min.to_date
    self.date_max = date_max.to_date

    return false if invalid?

    true
  end

  def search
    sells = set_sells

    sells = by_date(sells)

    sells.order(date_of_sell: :desc)
  end

  private

  def article_exists
    return unless article_id.present?

    errors.add(:article_id, :does_not_exist) unless Article.find_by(id: article_id).present?
  end

  def date_min_less_than_date_max
    return unless date_min.present? && date_max.present?

    errors.add(:date_max, :less_than_date_min) if date_min > date_max
  end

  def date_max_equal_today_date
    return unless date_max.present?

    errors.add(:date_max, :more_than_today) if date_max.to_date > Date.today
  end

  def set_sells
    return Article.find(article_id).sells if article_id.present?

    Sell.all
  end

  def by_date(sells)
    sells = Sell.filter_with_date_min(sells, date_min.to_date) if date_min.present?
    sells = Sell.filter_with_date_max(sells, date_max.to_date) if date_max.present?

    sells
  end
end

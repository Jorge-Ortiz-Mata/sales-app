class Sell < ApplicationRecord
  belongs_to :article, optional: true

  validates :quantity, :day, :date_of_sell, :article, presence: true
  validate :format_day

  DAYS = %w[LUNES MARTES MIERCOLES JUEVES VIERNES SABADO DOMINGO].freeze

  def total_revenue
    quantity * article.price
  end

  private

  def format_day
    return if DAYS.include?(day)

    errors.add(:day, :invalid_day)
  end
end

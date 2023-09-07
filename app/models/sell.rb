class Sell < ApplicationRecord
  validates :quantity, :day, :date_of_sell, :article, presence: true
  belongs_to :article, optional: true

  DAYS = %w[LUNES MARTES MIERCOLES JUEVES VIERNES SABADO DOMINGO].freeze

  def total_revenue
    quantity * article.price
  end
end

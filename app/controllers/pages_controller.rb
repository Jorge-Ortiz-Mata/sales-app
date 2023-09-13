class PagesController < ApplicationController
  def dashboard
    @revenue = Sell.sum(:total_revenue)
    @sells = Sell.all
    @articles = Article.all
  end

  def settings; end
end

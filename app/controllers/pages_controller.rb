class PagesController < ApplicationController
  def dashboard
    @revenue = ArticleSell.sum(:revenue).round(2)
    @sells = Sell.all
    @articles = Article.all
  end

  def settings; end
end

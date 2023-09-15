class ArticleSellsController < ApplicationController
  before_action :set_sell, only: %i[create destroy]
  before_action :set_article_sell, only: %i[destroy]

  def create
    @article_sell = @sell.article_sells.build(article_sell_params)

    respond_to do |format|
      if @article_sell.save
        format.turbo_stream { render turbo_stream: turbo_stream.replace('article_sells', partial: 'article_sells/article_sells', locals: { sell: @sell }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('article_sell_form', partial: 'article_sells/form', locals: { sell: @sell, article_sell: @article_sell, btn_text: 'Añadir articulo' }) }
      end
    end
  end

  def destroy
    @article_sell.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('article_sells', partial: 'article_sells/article_sells', locals: { sell: @sell }) }
    end
  end

  private

  def article_sell_params
    params.require(:article_sell).permit(:article_id, :quantity)
  end

  def set_sell
    @sell = Sell.find(params[:sell_id])
  end

  def set_article_sell
    @article_sell = ArticleSell.find(params[:id])
  end
end

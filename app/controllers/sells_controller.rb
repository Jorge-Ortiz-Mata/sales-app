class SellsController < ApplicationController
  before_action :set_sell, only: %i[ show edit update destroy ]

  def index
    @sells = Sell.order(date_of_sell: :desc)
    @sells_filter = SellsFilter.new
  end

  def show; end

  def new
    @sell = Sell.new
  end

  def edit; end

  def create
    @sell = Sell.new(sell_params)

    respond_to do |format|
      if @sell.save
        format.html { redirect_to sell_url(@sell), notice: 'La venta ha sido creada exitosamente.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @sell.update(sell_params)
        format.html { redirect_to sell_url(@sell), notice: 'La venta ha sido actualizada exitosamente.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sell.destroy

    respond_to do |format|
      format.html { redirect_to sells_url, notice: 'La venta ha sido eliminada exitosamente.' }
    end
  end

  def filter
    @sells_filter = SellsFilter.new sells_filter_params

    respond_to do |format|
      if @sells_filter.save
        sells_filtered = @sells_filter.search

        format.turbo_stream { render turbo_stream: turbo_stream.replace('sells', partial: 'sells/sells', locals: { sells: sells_filtered, sells_filter: @sells_filter }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('filter_form', partial: 'sells/filter_form', locals: { sells_filter: @sells_filter }) }
      end
    end
  end

  private

  def set_sell
    @sell = Sell.find(params[:id])
  end

  def sell_params
    params.require(:sell).permit(:date_of_sell, :description)
  end

  def sells_filter_params
    params.require(:sells_filter).permit(:article_id, :date_min, :date_max, :quantity)
  end
end

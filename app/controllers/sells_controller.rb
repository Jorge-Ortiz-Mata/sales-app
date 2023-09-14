class SellsController < ApplicationController
  before_action :set_sell, only: %i[ show edit update destroy ]

  def index
    @sells = Sell.order(date_of_sell: :desc)
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

  private

  def set_sell
    @sell = Sell.find(params[:id])
  end

  def sell_params
    params.require(:sell).permit(:article_id, :quantity, :date_of_sell, :comment)
  end
end

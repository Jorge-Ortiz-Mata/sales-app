class SellsController < AuthenticatedController
  before_action :set_sell, only: %i[show edit update destroy]

  def index
    @sells = Sell.order(date_of_sell: :desc)
    @sells_filter = SellsFilter.new
    authorize @sells
  end

  def show
    authorize @sell
  end

  def new
    @sell = Sell.new
    authorize @sell
  end

  def edit
    authorize @sell
  end

  def create
    @sell = Sell.new(sell_params)
    authorize @sell

    respond_to do |format|
      if @sell.save
        format.html { redirect_to sell_url(@sell), notice: 'La venta ha sido creada exitosamente.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('new_sell_form', partial: 'sells/form', locals: { sell: @sell, id: 'new_sell_form', btn_text: 'Crear' }) }
      end
    end
  end

  def update
    authorize @sell

    respond_to do |format|
      if @sell.update(sell_params)
        format.html { redirect_to sell_url(@sell), notice: 'La venta ha sido actualizada exitosamente.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('edit_sell_form', partial: 'sells/form', locals: { sell: @sell, id: 'edit_sell_form', btn_text: 'Actualizar' }) }
      end
    end
  end

  def destroy
    authorize @sell

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
    params.require(:sells_filter).permit(:date_min, :date_max)
  end
end

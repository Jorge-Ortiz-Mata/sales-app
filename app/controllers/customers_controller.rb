class CustomersController < AuthenticatedController
  before_action :set_customer, only: %i[edit update destroy]

  def index
    @customers = Customer.all.order(:full_name)
    authorize @customers
  end

  # def show
  #   authorize @customer
  # end

  def new
    @customer = Customer.new
    authorize @customer
  end

  def edit
    authorize @customer
  end

  def create
    @customer = Customer.new customer_params
    authorize @customer

    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_path, notice: 'El cliente ha sido añadido exitosamente' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @customer

    respond_to do |format|
      if @customer.update customer_params
        format.html { redirect_to customer_url(@customer), notice: 'El cliente ha sido actualizado exitosamente' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('customer_form', partial: 'customers/form', locals: { customer: @customer, btn_title: 'Actualizar cliente', cancel_path: customers_path }) }
      end
    end
  end

  def destroy
    authorize @customer
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'El cliente ha sido eliminado exitosamente' }
    end
  end

  def filter
    keyword = filter_params[:keyword]

    if keyword.present?
      customers = Customer.filter_by_name(keyword)
    else
      customers = Customer.all
    end

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('customers', partial: 'customers/customers', locals: { customers: customers }) }
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:full_name, :phone_number, :address)
  end

  def filter_params
    params.require(:filter).permit(:keyword)
  end
end

class CustomersController < AuthenticatedController
  before_action :set_customer, only: %i[edit update destroy]

  def index
    @customers = Customer.all.order(:created_at)
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
    @customer = Customer.new(customer_params)
    authorize @customer

    respond_to do |format|
      if @customer.save
        format.html { redirect_to customer_url(@customer), notice: 'Customer was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @customer

    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customer_url(@customer), notice: 'Customer was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @customer
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:full_name, :phone_number, :address)
  end
end

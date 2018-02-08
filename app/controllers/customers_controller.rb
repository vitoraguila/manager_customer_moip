class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:edit, :update, :destroy]

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params_customer)
    if @customer.save
      redirect_to customers_path, notice: "O cliente (#{@customer.email}) foi cadastrado com sucesso"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @customer.update(params_customer)
      redirect_to customers_path, notice: "O cliente (#{@customer.email}) foi atualizado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    customer_email = @customer.email

    if @customer.destroy
      redirect_to customers_path, notice: "O cliente (#{customer_email}) foi deletado com sucesso"
    else
      render :index
    end
  end

  private 

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def params_customer
      params.require(:customer).permit(:fullname, :email, :phone, :cpfcnpj, :address)
  end
end

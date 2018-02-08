class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_orders, only: [:edit, :update, :destroy]
  before_action :set_moip_config, only: [:index, :create, :new, :edit, :update, :refresh]

  def index
    @orders = Order.all
  end

  def refresh
    @orders = Order.all

    api = Moip2::Api.new(set_moip_config)
    @orders.each do |f|
      # CONSULTA O STATUS DO PEDIDO E SALVA
      pagamento = api.order.show("#{f.moipid}")
      if f.status != pagamento[:status]
        @order = Order.find(f.id)
        @order.status = pagamento[:status]
        @order.save
      end
    end 
    render :index
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(params_order)
    @order.status = 'WAITING'

    if @order.save
      
      api = Moip2::Api.new(set_moip_config)
      order_moip = api.order.create({
        own_id: "#{@order.id}",
        items: [
          {
            product: "#{@order.service.name}",
            quantity: 1,
            detail: "#{@order.service.detail}",
            price: @order.service.price
          }
        ],
        customer: {
          own_id: "#{@order.customer.id}",
          fullname: "#{@order.customer.fullname}",
          email: "#{@order.customer.email}",
        }
      })

      # SALVA O ID DO PEDIDO DO MOIP NO REGISTRO DO BANCO
      @order.moipid = order_moip.id
      @order.instruction1 = "teste1"
      @order.instruction2 = "teste2"
      @order.instruction3 = "teste3"

      @order.link_boleto = order_moip._links[:checkout][:pay_boleto][:redirect_href]

      @order.save

      api.payment.create(order_moip.id,
      {
        # ...
          funding_instrument: {
              method: "BOLETO",
              boleto: {
                  expiration_date: "#{@order.expiration_date}",
                  instruction_lines: {
                      first: "#{@order.instruction1}",
                      second: "#{@order.instruction2}",
                      third: "#{@order.instruction3}"
                    },
                  logo_uri: "http://www.agenciadavos.com.br/themes/agenciadavos/images/logo_original.png"
              }
          }
      }
      )

      redirect_to orders_path, notice: "O Pedido (#{@order.id}) foi cadastrado com sucesso"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @order.update(params_order)
      redirect_to orders_path, notice: "O Pedido (#{@order.id}) foi atualizado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    order_id = @order.id

    if @order.destroy
      redirect_to orders_path, notice: "O Pedido (#{order_id}) foi deletado com sucesso"
    else
      render :index
    end
  end

  private 

  def set_orders
    @order = Order.find(params[:id])
  end

  def params_order
      params.require(:order).permit(:customer_id, :service_id, :expiration_date, :instruction1, :instruction2, :instruction3, :moipid, :status, :created_at)
  end

  def set_moip_config
    auth = Moip2::Auth::Basic.new("YXZ56UUSD2NUQFK0JOUJYNXMBFKYUS0E", "TM3KO0HINUCPKATVR4TCVB35KRGBIOUHGKEOL6AA")
    clientMoip = Moip2::Client.new(:sandbox, auth)
  end

end

class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_services, only: [:edit, :update, :destroy]

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(params_service)
    if @service.save
      redirect_to services_path, notice: "O serviço (#{@service.name}) foi cadastrado com sucesso"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @service.update(params_service)
      redirect_to services_path, notice: "O serviço (#{@service.name}) foi atualizado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    service_name = @service.name

    if @service.destroy
      redirect_to services_path, notice: "O serviço (#{service_name}) foi deletado com sucesso"
    else
      render :index
    end
  end

  private 

  def set_services
    @service = Service.find(params[:id])
  end

  def params_service
      params.require(:service).permit(:name, :detail, :price, :recurrence)
  end


end

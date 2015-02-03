class ClientesController < ApplicationController
  before_filter :require_login
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]

  def index
    @admin = true
    respond_to do |format|
      format.html
      format.json { render json: ClientesDatatable.new(view_context) }
    end
  end

  def autocomplete
    respond_to do |format|
      format.json { render :json => Cliente.autocomplete(params[:term]) }
    end
  end

  def show
    respond_to do |format|
      format.js{ render "show" }
    end
  end

  def new
    @cliente= Cliente.new
    respond_to do |format|
      format.js{ render "new_or_edit" }
    end
  end

  def edit
    respond_to do |format|
      format.js{ render "new_or_edit" }
    end
  end

  def create
    @cliente = Cliente.new(cliente_params)
    respond_to do |format|
      @cliente.save
      format.js { render "success" }
    end
  end

  def update
    respond_to do |format|
      @cliente.update(cliente_params)
      format.js { render "success"}
      format.json { respond_with_bip(@cliente) }
    end
  end

  def destroy
    @cliente.destroy
    respond_to do |format|
      format.html { redirect_to clientes_url }
    end
  end

  private
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    def cliente_params
      params.require(:cliente).permit(:nombre, :direccion, :numero_de_identificacion, :telefono, :email, :estado_civil, :fecha_de_nacimiento, :sexo, :ocupacion)
    end
  end

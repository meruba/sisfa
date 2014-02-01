class ClientesController < ApplicationController
  before_filter :require_login
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]

  # GET /clientes
  # GET /clientes.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: ClientesDatatable.new(view_context) }
    end
  end

  def autocomplete
    # @cliente= Cliente.new
    respond_to do |format|
      format.html{
        @clientes = Cliente.all
      }
      format.json { 
        @clientes = Cliente.where("numero_de_identificacion like ?", "%#{params[:term]}%")
        @clientes = @clientes.map do |cliente|
          {
            :id => cliente.id,
            :label => cliente.numero_de_identificacion + " / " + cliente.nombre,
            :value => cliente.numero_de_identificacion,
            :nombre => cliente.nombre,
            :direccion => cliente.direccion,
            :telefono => cliente.telefono
          }
        end
        render :json => @clientes 
      }
    end
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show
    respond_to do |format|
      format.js{ render "show" }
    end
  end

  # GET /clientes/new
  def new
    @cliente= Cliente.new
    respond_to do |format|
      format.html
      format.js{ render "new_or_edit" }
    end
  end

  # GET /clientes/1/edit
  def edit
    respond_to do |format|
      format.js{ render "new_or_edit" }
    end
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)
    respond_to do |format|
      if @cliente.save
        @clientes = Cliente.all
        format.html { redirect_to @cliente, notice: 'Cliente was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cliente }
        format.js { 
          render "success"
        }
      else
        format.html { render action: 'index' }
        format.js{
          render "success"
        }
      end
    end
  end

  # PATCH/PUT /clientes/1
  # PATCH/PUT /clientes/1.json
  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        @clientes = Cliente.all
        format.html { redirect_to @cliente, notice: 'Cliente was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @cliente }
        format.js { render "success"}
      else
        format.html { render action: 'edit' }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
        format.js { render "success"}
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    @cliente.destroy
    respond_to do |format|
      format.html { redirect_to clientes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cliente_params
      params.require(:cliente).permit(:nombre, :direccion, :numero_de_identificacion, :telefono, :email)
    end
  end

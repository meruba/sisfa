class ProveedorsController < ApplicationController
	# GET /proveedor
  # GET /proveedors.json
  before_filter :require_login
  before_action :set_proveedor, only: [:show, :edit, :update, :destroy]
  
  def index
    respond_to do |format|
      format.html
      format.json { render json: ProveedorsDatatable.new(view_context) }
    end
  end
  def autocomplete
    # @proveedor = Proveedor.new
    respond_to do |format|
      format.html {    
        @proveedors = Proveedor.all
      }
      format.json { 
        @proveedors = Proveedor.where("nombre like ?", "%#{params[:term]}%")
        @proveedors = @proveedors.map do |proveedor|
          {
            :id => cliente.id,
            :label => cliente.numero_de_identificacion,
            :value => cliente.numero_de_identificacion,
            :nombre_o_razon_social => cliente.nombre_o_razon_social,
            :direccion => cliente.direccion,
            :telefono => cliente.telefono
          }
        end
        render :json => @proveedors
      }
    end    
  end

  # GET /proveedors/1
  # GET /proveedors/1.json
  def show
   respond_to do |format|
      format.js{ render "new" }
    end
  end

  # GET /proveedors/new
  def new
   @proveedor= Proveedor.new
    respond_to do |format|
      format.js{ render "init" }
    end
  end
  # GET /proveeodrs/1/edit
  def edit
    respond_to do |format|
      format.js{ render "init" }
    end
  end

  # POST /proveedors
  # POST /proveedors.json
  def create
    @proveedor = Proveedor.new(proveedor_params)
    respond_to do |format|
      if @proveedor.save
        @proveedors = Proveedor.all
        format.html { redirect_to @proveedor, notice: 'Proveedor was successfully created.' }
        format.json { render action: 'show', status: :created, location: @proveedor }
        format.js { 
          render "success"
        }
      else
        format.html { render action: 'new' }
        format.js
      end
    end
  end

  # PATCH/PUT /proveedors/1
  # PATCH/PUT /proveedors/1.json
  def update
   respond_to do |format|
      if @proveedor.update(proveedor_params)
        @proveedors = Proveedor.all
        format.html { redirect_to @proveedor, notice: 'Proveedor was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @proveedor}
        format.js { render "success"}
      else
        format.html { render action: 'edit' }
        format.json { render json: @proveedor.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /proveedors/1
  # DELETE /proveedors/1.json
  def destroy
    @articulo.destroy
    respond_to do |format|
      format.html { redirect_to proveedors_url }
      format.json { head :no_content }
    end
  end
  
  
  private 
  def proveedor_params
    params.require(:proveedor).permit(:nombre_o_razon_social, :direccion, :codigo, :numero_de_identificacion, :telefono, :ciduad, :pais, :representante_legal, :fax)
  end
  def set_proveedor
      @proveedor = Proveedor.find(params[:id])
    end

end

class ProductosController < ApplicationController
	before_filter :require_login
  before_filter :is_admin_or_vendedor_farmacia
  before_action :set_producto, only: [:show, :edit, :update]
  before_action :find_caducados, only: [:caducado, :alerta]
  
  def index
    respond_to do |format|
      format.html
      format.json { render json: ProductosDatatable.new(view_context) }
    end
  end

  def autocomplete
    respond_to do |format|
      format.json { render :json => IngresoProducto.autocomplete(params[:term]) }
    end    
  end

  def autocomplete_producto_compra
    respond_to do |format|
      format.json { render :json => Producto.autocomplete_producto_compra(params[:term]) }
    end  
  end

  def new
    @producto=  Producto.new
    @producto.ingreso_productos.build
    respond_to do |format|
      format.js{ render "new_or_edit" }
    end
  end

  def show
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    respond_to do |format|
      format.js{ render "new_or_edit" }
    end
  end

  def create
    @producto = Producto.new(producto_params)
    respond_to do |format|
      @producto.save
      format.js{ render "success" }
    end
  end

  def update
    respond_to do |format|
      @producto.update(producto_params)
        format.js{ render "success" }
    end
  end

  def inventario
    # @inventario = Producto.includes(:ingreso_productos).where("ingreso_productos.cantidad != 0").references(:ingreso_productos)
    @inventario = Producto.where("stock != 0")
  end

  def caducado
  end

  def alerta
    if @caducados.empty? == true
      redirect_to root_path
    end    
  end

  private 
  
  def producto_params
    params.require(:producto).permit :nombre,
    :nombre_generico,
    :codigo,
    :categoria,
    :casa_comercial,
    :precio_venta,
    :precio_compra,
    :ganancia,
    :hasiva,
    :ingreso_productos_attributes => [
      :lote,
      :cantidad,
      :fecha_caducidad,
      :producto_id,
      :_destroy,
      :id,
    ]                                    
  end  
  
  def set_producto
      @producto = Producto.find(params[:id])
  end

  def find_caducados
    @caducados = IngresoProducto.where(:fecha_caducidad =>Time.now.end_of_day..Time.now.months_since(4)).where("cantidad != '0'")
    @hoy = Date.today    
  end
end

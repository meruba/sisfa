class ProductosController < ApplicationController
	before_filter :require_login
  before_action :set_producto, only: [:show, :edit, :update]
  def index
    respond_to do |format|
      format.html
      format.json { render json: ProductosDatatable.new(view_context, "todos") }
    end
  end

  def autocomplete
    # @producto = Producto.new
    respond_to do |format|
      format.json { 
        @productos = IngresoProducto.includes(:producto).where("cantidad != 0 and productos.nombre like ?", "%#{params[:term]}%").references(:producto)
        @productos = @productos.map do |ingreso|
          {
            :id => ingreso.producto.id,
            :label => ingreso.producto.nombre + "/" + ingreso.lote ,
            :value => ingreso.producto.nombre,
            :precio_venta => ingreso.producto.precio_venta,
            :precio_compra => ingreso.producto.precio_compra,
            :ganancia => ingreso.producto.ganancia,
            :codigo => ingreso.producto.codigo,
            :casa_comercial => ingreso.producto.casa_comercial,
            :categoria => ingreso.producto.categoria,
            :id_ingreso => ingreso.id,
            :iva => ingreso.producto.hasiva,
            :nombre_generico => ingreso.producto.nombre_generico
          }
        end
        render :json => @productos 
      }
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
      if @producto.save
        @productos = Producto.all
        format.html { redirect_to @producto, notice: 'Producto guardado' }
        format.json { render action: 'show', status: :created, location: @producto }
        format.js{
          render "success"
        }
      else
        format.html { render action: 'new' }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
        format.js{
          render "success"
        }
      end
    end
  end

  def update
    respond_to do |format|
      if @producto.update(producto_params)
        @productos = Producto.all
        format.html { redirect_to @producto, notice: 'Producto was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @producto }
        format.js { render "success"}
      else
        format.html { render action: 'edit' }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
        format.js{
          render "success"
        }
      end
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
end

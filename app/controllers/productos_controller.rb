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
      format.html {    
        @productos = Producto.all
      }
      format.json { 
        @productos = Producto.where("nombre like ?", "%#{params[:term]}%")
        @productos = @productos.map do |producto|
          {
            :id => producto.id,
            :label => producto.nombre,
            :value => producto.nombre,
            :precio_venta => producto.precio_venta,
            :codigo => producto.codigo
          }
        end
        render :json => @productos 
      }
    end    
  end

  def new
    @producto=  Producto.new
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
                                     :cantidad_disponible,
                                     :precio_compra,
                                     :codigo,
                                     :categoria,
                                     :descripcion,
                                     :fecha_de_caducidad,
                                     :casa_comercial
  end  
  def set_producto
      @producto = Producto.find(params[:id])
    end
end

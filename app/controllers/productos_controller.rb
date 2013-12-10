class ProductosController < ApplicationController
	before_filter :require_login
  def index
    @producto = Producto.new
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
            :precio => producto.precio,
            :codigo => producto.codigo
          }
        end
        render :json => @productos 
      }
    end    
  end

  def new
    @producto = Producto.new
  end

  def create
    @producto = Producto.new(producto_params)
    respond_to do |format|
      if @producto.save
        format.html { redirect_to @producto, notice: 'Producto guardado' }
        format.json { render action: 'show', status: :created, location: @producto }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  private 
  def producto_params
    params.require(:producto).permit(:nombre,
     :precio,
     :codigo,
     :categoria,
     :descripcion,
     :fecha_de_caducidad,
     :casa_comercial)
  end  
end

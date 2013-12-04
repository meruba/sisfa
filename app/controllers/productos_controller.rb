class ProductosController < ApplicationController
	def new
		@producto = Producto.new
	end

	def create
		@producto = Producto.new(producto_params) 
      if @producto.save
        redirect_back_or_to(clientes_path, notice: "Productos Ingresados")
      else
        flash[:error] = "Datos no validos"
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

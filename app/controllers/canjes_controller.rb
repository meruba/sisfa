class CanjesController < ApplicationController
  before_action :set_ingreso, only: [:nuevo, :save_nuevo]

  def nuevo
    @canje = Canje.new
  end

  def save_nuevo
    @canje = Canje.new
    if params[:canje][:tipo] == "mismo_producto"
      mismo_producto = params[:canje].delete :entrada_nueva
      ingreso = IngresoProducto.new(:lote => mismo_producto[:lote], :fecha_caducidad => mismo_producto[:fecha_caducidad], :producto => @actual.producto, :cantidad => @actual.cantidad)
      if ingreso.save
        @canje.antiguo = @actual
        @canje.nuevo = ingreso
        @canje.save
        @actual.cantidad = 0
        @actual.save
        redirect_to productos_path
        flash[:notice] = 'Canje Realizado'
      end
    else
      producto_attr = params[:canje].delete :producto
      producto = Producto.find(producto_attr[:id])
      producto.ingreso_productos.create(
        :fecha_caducidad => producto_attr[:ingreso_productos][:fecha_caducidad],
        :cantidad => producto_attr[:ingreso_productos][:cantidad],
        :lote => producto_attr[:ingreso_productos][:lote]
        )
      if producto.save
        @canje.antiguo = @actual
        @canje.save
        @actual.cantidad = 0
        @actual.save
        redirect_to productos_path
        flash[:notice] = 'Canje Realizado'
      end
    end
  end

  private
  def set_ingreso
  	@actual = IngresoProducto.find(params[:id])
  end
end

class CanjesController < ApplicationController
  def nuevo
    @ingresoproducto = IngresoProducto.find(params[:id])
    @producto = Producto.new
  end
end

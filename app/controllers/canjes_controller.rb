class CanjesController < ApplicationController
  def nuevo
    @actual = IngresoProducto.find(params[:id])
    @ingresoproducto = IngresoProducto.new
    @producto = Producto.new
  end
end

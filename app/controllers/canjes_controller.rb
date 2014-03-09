class CanjesController < ApplicationController
  def nuevo
    @ingresoproducto = IngresoProducto.find(params[:id])
  end
end

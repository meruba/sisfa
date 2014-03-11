class CanjesController < ApplicationController
  def nuevo
    @actual = IngresoProducto.find(params[:id])
    @canje = Canje.new
  end
end

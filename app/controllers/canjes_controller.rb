class CanjesController < ApplicationController
  before_action :set_ingreso, only: [:nuevo, :save_nuevo]

  def nuevo
    @canje = Canje.new
  end

  def save_nuevo
    @canje = Canje.new
    mismo_producto = params[:canje].delete :entrada_nueva
    lote = mismo_producto[:lote]
    fecha = mismo_producto[:fecha_caducida]
  	@canje.antiguo_id = @actual.id
  	@canje.producto_id = @actual.producto.id
  	@canje.fecha = Time.now
  	@canje.tipo = "Mismo producto"
  	if @canje.save
  		redirect_to productos_path
      flash[:notice] = 'Canje Realizado'
  	else
  		raise
  	end
  end

  private
  def set_ingreso
  	@actual = IngresoProducto.find(params[:id])
  end
end

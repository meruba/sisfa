class CanjesController < ApplicationController
  before_action :set_ingreso, only: [:nuevo, :save_nuevo]

  def nuevo
    @canje = Canje.new
  end

  def save_nuevo
    canje = Canje.new
    if params[:tipo] = "mismo_producto"
      mismo_producto = params[:canje].delete :entrada_nueva
      lote = mismo_producto[:lote]
      fecha = mismo_producto[:fecha_caducidad]
      canje.antiguo_id = @actual.id
      canje.mismo_producto(fecha,lote)
      if canje.save
        redirect_to productos_path
        flash[:notice] = 'Canje Realizado'
      else
        redirect_to productos_path
        flash[:error] = 'Error en canje'
      end
    else
      #falta si es nuevo
    end
  end

  private
  
  def set_ingreso
  	@actual = IngresoProducto.find(params[:id])
  end
end

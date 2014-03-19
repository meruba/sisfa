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
    end
  end

  private
  def set_ingreso
  	@actual = IngresoProducto.find(params[:id])
  end
end

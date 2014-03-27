class CanjesController < ApplicationController
  before_action :set_ingreso, only: [:nuevo, :save_nuevo]

  def nuevo
    @canje = Canje.new
  end

  def save_nuevo
    @canje = Canje.new
    if params[:canje][:tipo] == "mismo_producto"
      producto = params[:canje].delete :entrada_nueva
      if producto[:fecha_caducidad].empty? or producto[:lote].empty?
        redirect_to productos_path
        flash[:error] = 'Tienes campos en blanco'
      end
      @canje.mismo_producto(producto, @actual)
      @canje.save
      redirect_to productos_path
      flash[:notice] = 'Canje Realizado'
    else
      nuevo_producto = params[:canje].delete :producto
      @canje.otro_producto(nuevo_producto, @actual)
      @canje.save
      redirect_to productos_path
      flash[:notice] = 'Canje Realizado'
    end
  end

  private
  def set_ingreso
  	@actual = IngresoProducto.find(params[:id])
  end
end

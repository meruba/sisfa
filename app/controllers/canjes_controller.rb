class CanjesController < ApplicationController
  before_action :find_ingreso, only: [:new, :create]

  def new
    @canje = Canje.new
  end

  def create
    @canje = Canje.new
    if params[:canje][:tipo] == "mismo_producto"
      producto = params[:canje].delete :entrada_nueva
      if producto[:fecha_caducidad].empty? or producto[:lote].empty?
        render action: "new"
        flash[:error] = 'Tienes campos en blanco'
      else
        @canje.mismo_producto(producto, @actual)
        @canje.save
        redirect_to productos_path
        flash[:notice] = 'Canje Realizado'
      end
    else
      nuevo_producto = params[:canje].delete :producto
      @canje.otro_producto(nuevo_producto, @actual)
      @canje.save
      redirect_to productos_path
      flash[:notice] = 'Canje Realizado'
    end
  end

  private
  def find_ingreso
  	@ingreso = IngresoProducto.find(params[:ingreso_producto_id])
  end
end

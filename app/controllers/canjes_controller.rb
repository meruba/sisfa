class CanjesController < ApplicationController
  before_action :require_login
  before_action :find_ingreso

  def new
    @canje = Canje.new
  end

  def create
    @canje = Canje.new(canje_params)
    if @canje.save
      redirect_to productos_path
      flash[:notice] = 'Canje Realizado'
    else
      render action: "new"
    end
  end

  private
  def find_ingreso
  	@ingreso = IngresoProducto.find(params[:ingreso_producto_id])
  end

  def canje_params
    params.require(:canje).permit :tipo,
    :nuevo_attributes => [
      :id,
      :lote,
      :fecha_caducidad
    ],
    :producto_attributes => [
      :id,
      :nombre,
      :nombre_generico,
      :codigo,
      :categoria,
      :casa_comercial,
      :precio_compra,
      :ganancia,
      :hasiva,
      :ingreso_productos_attributes => [
        :lote,
        :fecha_caducidad,
        :cantidad,
        :id
      ]
    ]
  end
end

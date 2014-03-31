class FacturaComprasController < ApplicationController
  before_filter :require_login
  before_action :set_factura, only: :show
  
  def new
    @facturacompra = FacturaCompra.new
    @facturacompra.build_proveedor
    @facturacompra.factura_compras_productos.build.build_producto
  end
  
  def show
    respond_to do |format|
      format.js
    end
  end

  def create
      @facturacompra = FacturaCompra.new(factura_params.merge(user_id: current_user.id))
      if @facturacompra.save
        redirect_to facturas_path, :notice => "Factura Guardada"
      else
        render action: "new"
      end
  end

  private
  
  def factura_params
    params.require(:factura_compra).permit :numero,
    :observacion,
    :fecha_de_emision,
    :fecha_de_vencimiento,
    :subtotal_0,
    :iva,
    :total,
    :tipo,
    :user_id,
    :proveedor_id,
    :proveedor_attributes => [
      :id,
      :nombre_o_razon_social,
      :direccion,
      :telefono,
      :numero_de_identificacion
    ],
    :factura_compras_productos_attributes => [
      :producto_id,
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
    ]
  end

  def set_factura
    @factura = FacturaCompra.find(params[:id])
  end

end

class FacturaComprasController < ApplicationController
  before_filter :require_login
  before_filter :is_admin_or_vendedor_farmacia
  before_action :set_factura, only: :show

  def new
    @facturacompra = FacturaCompra.new
    @facturacompra.build_proveedor
    @facturacompra.factura_compras_productos.build.build_producto
  end

  def show
    respond_to do |format|
      format.js
      format.html
      format.pdf do
        render :pdf => "factura", :layout => 'report.html', :template => "factura_compras/pdf.html.erb"
      end
    end
  end

  def create
    respond_to do |format|
      @facturacompra = FacturaCompra.new(factura_params.merge(user_id: current_user.id))
      @facturacompra.save
      format.js
    end
  end

  private

  def factura_params
    params.require(:factura_compra).permit :numero,
    :observacion,
    :fecha_de_emision,
    :fecha_de_vencimiento,
    :subtotal_0,
    :subtotal_12,
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
          :id,
          :_destroy
        ]
      ]
    ]
  end

  def set_factura
    @factura = FacturaCompra.find(params[:id])
  end

end

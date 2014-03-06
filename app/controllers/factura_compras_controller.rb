class FacturaComprasController < ApplicationController
  before_filter :require_login
  before_action :set_proveedor, only: :create
  
  def new
    @facturacompra = FacturaCompra.new
  end

  def create
    if @proveedor.save
      @facturacompra = @proveedor.factura_compras.build(factura_params)
      @facturacompra.user_id = current_user.id
      if @facturacompra.save
        redirect_to facturas_path, :notice => "Factura Guardada"
      else
        flash[:error] = "Error al facturar"
        redirect_to facturas_path
      end
    else
      flash[:error] = 'Errores en Proveedor'
      @facturacompra = @proveedor.factura_compras.build
      render "new"
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
    :descuento,
    :iva,
    :total,
    :tipo,
    :user_id,
    :cliente_id,
    :productos_attributes => [
      :nombre,
      :nombre_generico,
      :codigo,
      :categoria,
      :casa_comercial,
      :ingreso_productos_attributes => [
        :lote,
        :fecha_caducidad,
        :cantidad,
        :precio_compra,
        :ganancia,
        :hasiva,
        :_destroy
      ]
    ]
  end

  def set_proveedor
    proveedor_attrs = params[:factura_compra].delete :proveedor
    @proveedor = proveedor_attrs[:id].present? ? Proveedor.update(proveedor_attrs[:id],proveedor_attrs) : Proveedor.create(proveedor_attrs)
  end
end

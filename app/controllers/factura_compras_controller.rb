class FacturaComprasController < ApplicationController
  
  def new
    @facturacompra = FacturaCompra.new
  end

  def create
    proveedor_attrs = params[:factura_compra].delete :proveedor
    @proveedor = proveedor_attrs[:id].present? ? Proveedor.update(proveedor_attrs[:id],proveedor_attrs) : Proveedor.create(proveedor_attrs)
    if @proveedor.save
      @factura = @proveedor.factura_compras.build(factura_params)
      @factura.user_id = current_user.id
      @factura.fecha_de_emision = Time.now
      @factura.fecha_de_vencimiento = Time.now + 30.days
      @factura.descuento = 0
      @factura.iva = 0
      @factura.total = 0
      @factura.subtotal_12 = 0
      @factura.subtotal_0 = 0
      # Factura.item_compra(@factura.item_facturas)
        # raise 'error'
      if @factura.save
        # Factura.aumentar_stock(@factura.item_facturas)
        # redirect_to "compra", :notice => "Factura Guardada"
        redirect_to facturas_path, :notice => "Factura Guardada"
      else
        # render "compra"
        flash[:error] = "Error al facturar"
        redirect_to facturas_path
      end
    else
      flash[:error] = 'Errores en Proveedor'
      @factura.item_facturas.build
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
end

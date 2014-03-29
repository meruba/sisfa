class FacturaComprasController < ApplicationController
  before_filter :require_login
  before_action :set_factura, only: :show
  before_action :set_proveedor, :save_producto, only: :create
  
  def new
    @facturacompra = FacturaCompra.new
    @facturacompra.factura_compras_productos.build
  end
  
  def show
    respond_to do |format|
      format.js
    end
  end

  def create
    if @proveedor.save
      @facturacompra = @proveedor.factura_compras.build(factura_params)
      @facturacompra.user_id = current_user.id
      if @facturacompra.save
        redirect_to facturas_path, :notice => "Factura Guardada"
      else
        render "new"
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
    :iva,
    :total,
    :tipo,
    :user_id,
    :proveedor_id,
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

  def set_proveedor
    proveedor_attrs = params[:factura_compra].delete :proveedor
    @proveedor = proveedor_attrs[:id].present? ? Proveedor.update(proveedor_attrs[:id],proveedor_attrs) : Proveedor.create(proveedor_attrs)
  end

  def save_producto  
    items = params[:factura_compra][:factura_compras_productos_attributes]
    items.each do |value, producto|
      producto  = params[:factura_compra][:factura_compras_productos_attributes][value].delete :producto_attributes
      if producto[:id].empty?
        #es nuevo producto
        producto.delete("_destroy")
        Producto.create(producto)
      else
        #ya existe este producto
        ingreso_attr = producto.delete :ingreso_productos_attributes
        ingreso_attr.each do |value, ingreso| #agrega ingreso al producto
          IngresoProducto.create(:producto_id => producto[:id], :fecha_caducidad => ingreso[:fecha_caducidad],
            :lote => ingreso[:lote], :cantidad => ingreso[:cantidad])
        end
      end
    end
  end
end

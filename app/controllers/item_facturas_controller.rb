class ItemFacturasController < ApplicationController

  def new
    @itemfactura = Item_factura.new
  end

  def create
    @itemfactura = Item_factura.new(item_factura_params)
    if @itemfactura.save
    else
      flash[:notice] = 'error'
    end 
  end

  private

  def item_factura_params
  	params.require.(:item_factura).permit :cantidad,
	  																:valor_unitario,
	  																:descuento,
	  																:iva,
	  																:total
  	
  end
end

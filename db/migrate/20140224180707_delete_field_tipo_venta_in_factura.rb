class DeleteFieldTipoVentaInFactura < ActiveRecord::Migration
  def change
  	remove_column :facturas, :tipo_venta
  end
end

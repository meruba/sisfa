class AddTipoFacturaVentaToFactura < ActiveRecord::Migration
  def change
  	add_column :facturas, :tipo_venta, :string
  end
end

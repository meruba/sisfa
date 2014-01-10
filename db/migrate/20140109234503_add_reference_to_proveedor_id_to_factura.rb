class AddReferenceToProveedorIdToFactura < ActiveRecord::Migration
  def up
  	add_column :facturas, :proveedor_id, :integer
  end
  def down
  	remove_column :facturas, :proveedor_id
  end
end

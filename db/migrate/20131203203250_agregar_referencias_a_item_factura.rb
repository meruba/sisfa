class AgregarReferenciasAItemFactura < ActiveRecord::Migration
	def up
		add_column :item_facturas, :producto_id, :integer, :null => false
		add_column :item_facturas, :factura_id, :integer, :null => false
	end

	def down
		remove_column :item_facturas, :producto_id
		remove_column :item_facturas, :factura_id
	end
end

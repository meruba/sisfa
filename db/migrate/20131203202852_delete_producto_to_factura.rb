class DeleteProductoToFactura < ActiveRecord::Migration
	def up
		remove_column :facturas, :producto_id
	end

	def down
		add_column :facturas, :producto_id, :integer
	end
end

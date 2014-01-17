class AgregarTipoEnItemFacturas < ActiveRecord::Migration
	def up
		add_column :item_facturas, :tipo, :string
	end
	def down
		remove_column :item_facturas
	end
end

class RemoveItemFacturaToItemProforma < ActiveRecord::Migration
	def up
		remove_column :item_proformas, :itemFactura_id
	end

	def down
		add_column :item_proformas, :itemFactura_id, :integer
	end
end

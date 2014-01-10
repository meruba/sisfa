class CambiandoClienteIdEnFacturas < ActiveRecord::Migration
	def up
		remove_column :facturas, :cliente_id
		add_column :facturas, :cliente_id, :integer
	end
	def down
		remove_column :facturas, :cliente_id
		add_column :facturas, :cliente_id, :integer, :null=>false
	end
end

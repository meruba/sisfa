class AgregarCampoRolUsuario < ActiveRecord::Migration
	def up
		add_column :users, :rol, :string, :null => false
	end

	def down
		remove_column :users, :rol
	end
end

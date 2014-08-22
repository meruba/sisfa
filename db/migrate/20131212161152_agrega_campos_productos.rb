class AgregaCamposProductos < ActiveRecord::Migration

	def up
		add_column :productos, :nombre_generico, :string
		add_column :productos, :precio_b, :float
		add_column :productos, :precio_c, :float
		rename_column :productos, :precio, :precio_a
	end

	def down
		remove_column :productos, :nombre_generico
		remove_column :productos, :precio_b
		remove_column :productos, :precio_c
		rename_column :productos, :precio_a, :precio
	end

end

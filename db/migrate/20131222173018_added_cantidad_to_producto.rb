class AddedCantidadToProducto < ActiveRecord::Migration
  def up
  	add_column :productos, :cantidad_disponible, :float, :null => false
  end
  def down
  	remove_column :productos, :cantidad_disponible
  end
end

class AddGananciaToProducto < ActiveRecord::Migration
  def change
    add_column :productos, :ganancia, :float, :null => false
  end
end

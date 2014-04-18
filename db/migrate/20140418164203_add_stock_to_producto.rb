class AddStockToProducto < ActiveRecord::Migration
  def change
    add_column :productos, :stock, :integer, default: 0, null: false
  end
end

class UpdateValuesAtProductos < ActiveRecord::Migration
  def change
    rename_column :productos, :precio_a, :precio_compra
    rename_column :productos, :precio_b, :precio_venta
    remove_column :productos, :precio_c
  end
end

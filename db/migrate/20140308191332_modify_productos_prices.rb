class ModifyProductosPrices < ActiveRecord::Migration
  def change
    remove_column :ingreso_productos, :precio_compra
    remove_column :ingreso_productos, :precio_venta
    remove_column :ingreso_productos, :ganancia
    remove_column :ingreso_productos, :hasiva
    add_column :productos, :precio_compra, :decimal, precision: 4, scale: 2, null: false
    add_column :productos, :precio_venta, :decimal, precision: 4, scale: 2, null: false
    add_column :productos, :ganancia, :decimal, precision: 4, scale: 2, null: false
    add_column :productos, :hasiva, :boolean, :default => false
  end
end

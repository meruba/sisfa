class RemoveUnnecessaryFieldsInProducto < ActiveRecord::Migration
  def change
    remove_column :productos, :precio_compra
    remove_column :productos, :fecha_de_caducidad
    remove_column :productos, :precio_venta
    remove_column :productos, :cantidad_disponible
    remove_column :productos, :ganancia
  end
end

class Precio2Decimales < ActiveRecord::Migration
  def change
  change_column :productos, :precio_venta, :decimal, :precision => 4, :scale => 2
  change_column :productos, :precio_compra, :decimal, :precision => 4, :scale => 2
  end
end

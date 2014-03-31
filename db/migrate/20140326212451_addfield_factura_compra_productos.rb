class AddfieldFacturaCompraProductos < ActiveRecord::Migration
  def up
    add_column :factura_compras_productos, :cantidad, :float, null: false
    add_column :factura_compras_productos, :valor_unitario, :float, null: false
    add_column :factura_compras_productos, :iva, :float, null: false
    add_column :factura_compras_productos, :total, :float, null: false
  end

  def down
  	remove_column :factura_compras_productos, :cantidad
    remove_column :factura_compras_productos, :valor_unitario
    remove_column :factura_compras_productos, :iva
    remove_column :factura_compras_productos, :total
  end
end

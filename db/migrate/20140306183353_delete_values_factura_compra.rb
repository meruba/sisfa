class DeleteValuesFacturaCompra < ActiveRecord::Migration
  def up
  	remove_column :factura_compras, :subtotal_12
    remove_column :factura_compras, :descuento
  end

  def down
  	add_column :factura_compras, :subtotal_12, :float, :null => false
    add_column :factura_compras, :descuento, :float, :null => false
  end
end

class AddFieldsLiquidacionAndFacturaCompra < ActiveRecord::Migration
  def up
    add_column :liquidacions, :subtotal12_compra, :float, :default => 0
    add_column :liquidacions, :anulados_ventanilla, :integer, :default => 0
    add_column :factura_compras, :subtotal_12, :float
  end

  def down
  	remove_column :liquidacions, :subtotal12_compra
    remove_column :liquidacions, :anulados_ventanilla
    remove_column :factura_compras, :subtotal_12
  end
end


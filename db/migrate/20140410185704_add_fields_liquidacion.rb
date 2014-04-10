class AddFieldsLiquidacion < ActiveRecord::Migration
  def up
    add_column :liquidacions, :subtotal12_ventanilla, :float, :default => 0
    add_column :liquidacions, :subtotal12_hospitalizacion, :float, :default => 0
    add_column :liquidacions, :subtotal12_traspaso, :float, :default => 0
    add_column :liquidacions, :subtotal12_venta, :float, :default => 0
    add_column :liquidacions, :subtotal_venta, :float, :default => 0
    add_column :liquidacions, :iva_venta, :float, :default => 0
    add_column :liquidacions, :total_venta, :float, :default => 0
  end

  def down
  	remove_column :liquidacions, :subtotal12_ventanilla
    remove_column :liquidacions, :subtotal12_hospitalizacion
    remove_column :liquidacions, :subtotal12_traspaso
    remove_column :liquidacions, :subtotal12_venta
    remove_column :liquidacions, :subtotal_venta
    remove_column :liquidacions, :iva_venta
    remove_column :liquidacions, :total_venta
  end
end

class AddMoreFieldsLiquidacion < ActiveRecord::Migration
  def change
  	add_column :liquidacions, :total_sin_iva_ventanilla, :float, :default => 0
  	add_column :liquidacions, :total_sin_iva_hospitalizacion, :float, :default => 0
  	add_column :liquidacions, :total_sin_iva_traspaso, :float, :default => 0
  	add_column :liquidacions, :total_sin_iva_compra, :float, :default => 0
  	add_column :liquidacions, :total_sin_iva_venta, :float, :default => 0
  	add_column :liquidacions, :saldo_anterior, :float, :default => 0
  	add_column :liquidacions, :saldo_final, :float, :default => 0
  	add_column :liquidacions, :costo_venta, :float, :default => 0
  	add_column :liquidacions, :utilidad, :float, :default => 0
  end
end

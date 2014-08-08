class ChangeDecimalLiquidacion < ActiveRecord::Migration
	def up
		change_column :liquidacions, :iva_ventanilla, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :iva_hospitalizacion, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :iva_traspaso, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :iva_compra, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal_ventanilla, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal_hospitalizacion, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal_traspaso, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal_compra, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_ventanilla, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_hospitalizacion, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_traspaso, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_compra, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal12_ventanilla, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal12_hospitalizacion, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal12_traspaso, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal12_compra, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal12_venta, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal_venta, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :iva_venta, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_venta, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_sin_iva_ventanilla, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_sin_iva_hospitalizacion, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_sin_iva_traspaso, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_sin_iva_compra, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_sin_iva_venta, :decimal, precision: 5, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :saldo_anterior, :decimal, precision: 7, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :saldo_final, :decimal, precision: 7, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :costo_venta, :decimal, precision: 7, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :utilidad, :decimal, precision: 7, scale: 2, default: 0.00, null: false
	end
	def down
		change_column :liquidacions, :iva_ventanilla, :float, default: 0
		change_column :liquidacions, :iva_hospitalizacion, :float, default: 0
		change_column :liquidacions, :iva_traspaso, :float, default: 0
		change_column :liquidacions, :iva_compra, :float, default: 0
		change_column :liquidacions, :subtotal_ventanilla, :float, default: 0
		change_column :liquidacions, :subtotal_hospitalizacion, :float, default: 0
		change_column :liquidacions, :subtotal_traspaso, :float, default: 0
		change_column :liquidacions, :subtotal_compra, :float, default: 0
		change_column :liquidacions, :total_ventanilla, :float, default: 0
		change_column :liquidacions, :total_hospitalizacion, :float, default: 0
		change_column :liquidacions, :total_traspaso, :float, default: 0
		change_column :liquidacions, :total_compra, :float, default: 0
		change_column :liquidacions, :subtotal12_ventanilla, :float, default: 0
		change_column :liquidacions, :subtotal12_hospitalizacion, :float, default: 0
		change_column :liquidacions, :subtotal12_traspaso, :float, default: 0
		change_column :liquidacions, :subtotal12_compra, :float, default: 0
		change_column :liquidacions, :subtotal12_venta, :float, default: 0
		change_column :liquidacions, :subtotal_venta, :float, default: 0
		change_column :liquidacions, :iva_venta, :float, default: 0
		change_column :liquidacions, :total_venta, :float, default: 0
		change_column :liquidacions, :total_sin_iva_ventanilla, :float, default: 0
		change_column :liquidacions, :total_sin_iva_hospitalizacion, :float, default: 0
		change_column :liquidacions, :total_sin_iva_traspaso, :float, default: 0
		change_column :liquidacions, :total_sin_iva_compra, :float, default: 0
		change_column :liquidacions, :total_sin_iva_venta, :float, default: 0
		change_column :liquidacions, :saldo_anterior, :float, default: 0
		change_column :liquidacions, :saldo_final, :float, default: 0
		change_column :liquidacions, :costo_venta, :float, default: 0
		change_column :liquidacions, :utilidad, :float, default: 0
	end
end

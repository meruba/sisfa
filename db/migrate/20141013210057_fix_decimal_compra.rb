class FixDecimalCompra < ActiveRecord::Migration
	def up
		change_column :liquidacions, :iva_ventanilla, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :iva_hospitalizacion, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :iva_traspaso, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :iva_compra, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal_ventanilla, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal_hospitalizacion, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal_traspaso, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal_compra, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_ventanilla, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_hospitalizacion, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_traspaso, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_compra, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal12_ventanilla, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal12_hospitalizacion, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal12_traspaso, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal12_compra, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal12_venta, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :subtotal_venta, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :iva_venta, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_venta, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_sin_iva_ventanilla, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_sin_iva_hospitalizacion, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_sin_iva_traspaso, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_sin_iva_compra, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :total_sin_iva_venta, :decimal, precision: 8, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :saldo_anterior, :decimal, precision: 9, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :saldo_final, :decimal, precision: 9, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :costo_venta, :decimal, precision: 9, scale: 2, default: 0.00, null: false
		change_column :liquidacions, :utilidad, :decimal, precision: 9, scale: 2, default: 0.00, null: false
	end
	def down
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
end

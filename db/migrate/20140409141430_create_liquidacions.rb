class CreateLiquidacions < ActiveRecord::Migration
  def change
    create_table :liquidacions do |t|
    	t.float :iva_ventanilla, :default => 0
    	t.float :iva_hospitalizacion, :default => 0
    	t.float :iva_traspaso, :default => 0
    	t.float :iva_compra, :default => 0
    	t.float :subtotal_ventanilla, :default => 0
    	t.float :subtotal_hospitalizacion, :default => 0
    	t.float :subtotal_traspaso, :default => 0
    	t.float :subtotal_compra, :default => 0
    	t.float :total_ventanilla, :default => 0
    	t.float :total_hospitalizacion, :default => 0
    	t.float :total_traspaso, :default => 0
    	t.float :total_compra, :default => 0
    	t.integer :emitidos_ventanilla, :default => 0
    	t.integer :emitidos_hospitalizacion, :default => 0
    	t.integer :emitidos_traspaso, :default => 0
    	t.integer :emitidos_compra, :default => 0
    	t.date :fecha
      t.timestamps
    end
  end
end

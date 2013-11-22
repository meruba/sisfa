class CreateProformas < ActiveRecord::Migration
  def change
    create_table :proformas do |t|
    	t.date :fecha_emision, :null =>false
    	t.integer :numero, :null => false
    	t.float :iva, :null => false
    	t.float :subtotal_0, :null => false
    	t.float :subtotal_12, :null => false
    	t.float :descuento, :null => false
    	t.float :total, :null => false
      t.timestamps
    end
  end
end

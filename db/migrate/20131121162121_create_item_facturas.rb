class CreateItemFacturas < ActiveRecord::Migration
  def change
    create_table :item_facturas do |t|
    	t.integer :cantidad, :null => false
      t.float :valor_unitario, :null => false
      t.float :descuento
      t.float :iva, :null => false
      t.float :total, :null => false
      t.timestamps
    end
  end
end

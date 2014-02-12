class CreateItemTraspasos < ActiveRecord::Migration
  def change
    create_table :item_traspasos do |t|
    	t.float :cantidad, :null => false
      t.float :valor_unitario, :null => false
      t.float :total, :null => false
      t.float :iva, :null => false
    	t.references :producto, :index => true
      t.timestamps
    end
  end
end

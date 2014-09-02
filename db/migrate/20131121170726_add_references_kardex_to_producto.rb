class AddReferencesKardexToProducto < ActiveRecord::Migration
  def up
  	change_table :kardexes do |t|
  		t.references :producto, :null => false
  end
  end

  def down
  	remove column :kardexes, :producto_id
  end
end



class AddReferenceFacturaToProducto < ActiveRecord::Migration
  def up
  	change_table :facturas do |t|
      t.references :producto, :null => false
    end
  end

  def down
  	remove_column :facturas, :producto_id
  end
end

class AddFieldTipoToFactura < ActiveRecord::Migration
  def up
  	add_column :facturas, :tipo, :string, :null => false
  end
  def down
  	remove_column :facturas, :tipo
  end
end

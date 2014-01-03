class AddFieldEstadoFactura < ActiveRecord::Migration
  def up
  	add_column :facturas, :anulada, :boolean, :default => false
  end
  def down
  	remove_column :facturas, :anulada
  end
end

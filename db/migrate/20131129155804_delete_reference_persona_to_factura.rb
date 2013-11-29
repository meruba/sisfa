class DeleteReferencePersonaToFactura < ActiveRecord::Migration
  def up
  	remove_column :facturas, :persona_id
  end
  def down
  	add_column :facturas, :persona_id
  end
end

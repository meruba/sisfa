class AddReferenceFacturaToPersona < ActiveRecord::Migration
  def up
  	change_table :facturas do |t|
      t.references :persona, :null => false
    end
  end

  def down
  	remove_column :facturas, :persona_id
  end
end

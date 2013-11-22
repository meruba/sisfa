class AddReferencesLineaKardexToKardex < ActiveRecord::Migration
  def up
  	change_table :lineakardexes do |t|
  		t.references :kardex, :null => false
  end
end
 def down
  	remove column :lineakardexes, :kardex_id
  end
end

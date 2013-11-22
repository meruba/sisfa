class CreateLineakardexes < ActiveRecord::Migration
  def change
    create_table :lineakardexes do |t|
    	t.string :tipo, :null => false
    	t.date :fecha, :null => false
    	t.float :cantidad, :null => false
    	t.float :v_unitario, :null => false
      t.timestamps
    end
  end
end

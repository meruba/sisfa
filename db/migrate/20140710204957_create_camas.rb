class CreateCamas < ActiveRecord::Migration
  def change
    create_table :camas do |t|
    	t.references :cuarto, index: true
    	t.integer :numero
    	t.boolean :ocupada, default: false
      t.timestamps
    end
  end
end

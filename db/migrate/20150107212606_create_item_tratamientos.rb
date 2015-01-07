class CreateItemTratamientos < ActiveRecord::Migration
  def change
    create_table :item_tratamientos do |t|
    	t.string :codigo
    	t.string :nombre
    	t.references :tratamiento, index: true
      t.timestamps
    end
  end
end

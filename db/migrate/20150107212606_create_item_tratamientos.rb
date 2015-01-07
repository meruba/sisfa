class CreateItemTratamientos < ActiveRecord::Migration
  def change
    create_table :item_tratamientos do |t|

      t.timestamps
    end
  end
end

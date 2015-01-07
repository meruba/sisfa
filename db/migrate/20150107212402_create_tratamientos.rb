class CreateTratamientos < ActiveRecord::Migration
  def change
    create_table :tratamientos do |t|

      t.timestamps
    end
  end
end

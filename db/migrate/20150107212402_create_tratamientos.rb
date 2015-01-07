class CreateTratamientos < ActiveRecord::Migration
  def change
    create_table :tratamientos do |t|
    	t.string :nombre
    	t.string :numeracion
      t.timestamps
    end
  end
end

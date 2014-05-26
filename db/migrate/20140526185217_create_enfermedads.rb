class CreateEnfermedads < ActiveRecord::Migration
  def change
    create_table :enfermedads do |t|
    	t.string :nombre
    	t.string :codigo
      t.timestamps
    end
  end
end

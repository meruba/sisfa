class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
    	t.string :nombre
    	t.string :especialidad
      t.timestamps
    end
  end
end

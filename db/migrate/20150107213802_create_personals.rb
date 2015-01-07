class CreatePersonals < ActiveRecord::Migration
  def change
    create_table :personals do |t|
    	t.references :cliente, index: true

      t.timestamps
    end
  end
end

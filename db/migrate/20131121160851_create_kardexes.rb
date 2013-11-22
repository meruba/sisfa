class CreateKardexes < ActiveRecord::Migration
  def change
    create_table :kardexes do |t|
    	t.date :fecha

      t.timestamps
    end
  end
end

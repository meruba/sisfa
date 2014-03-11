class CreateCanjes < ActiveRecord::Migration
  def change
    create_table :canjes do |t|
      t.integer :antiguo_id, index: true
      t.integer :nuevo_id, index: true
      t.references :producto
      t.datetime :fecha
      t.timestamps
    end
  end
end

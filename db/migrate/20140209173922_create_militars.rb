class CreateMilitars < ActiveRecord::Migration
  def change
    create_table :militars do |t|
      t.string :grado
      t.string :codigo_issfa
      t.timestamps
    end
  end
end

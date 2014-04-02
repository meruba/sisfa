class AddFieldToCanje < ActiveRecord::Migration
  def up
    add_column :canjes, :cantidad, :float, null: false
    add_column :canjes, :precio_salida, :float, null: false
    add_column :canjes, :total, :float, null: false
  end

  def down
  	remove_column :canjes, :cantidad
    remove_column :canjes, :precio_salida
    remove_column :canjes, :total
  end
end

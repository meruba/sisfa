class AddIvaTraspaso < ActiveRecord::Migration
  def up
    add_column :item_traspasos, :iva, :float, nil => false
  end

  def down
    remove_column :item_traspasos, :iva
  end
end

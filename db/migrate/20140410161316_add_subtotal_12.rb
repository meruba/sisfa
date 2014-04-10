class AddSubtotal12 < ActiveRecord::Migration
  def up
    add_column :hospitalizacions, :subtotal_12, :float, null: false
    add_column :traspasos, :subtotal_12, :float, null: false
  end

  def down
  	remove_column :hospitalizacions, :subtotal_12
    remove_column :traspasos, :subtotal_12
  end
end

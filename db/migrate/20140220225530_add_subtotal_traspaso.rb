class AddSubtotalTraspaso < ActiveRecord::Migration
  def change
  	add_column :traspasos, :subtotal, :float, :null => false
  end
end

class AddTurnosOtherDays < ActiveRecord::Migration
  def up
  	add_column :emisors, :otros_dias, :boolean, :default => false
  end
  def down
  	remove_column :emisors, :otros_dias
  end
end

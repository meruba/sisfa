class AddDefaultTurnos < ActiveRecord::Migration
  def up
    change_column :emisors, :numero_turnos_fisiatria, :integer, :default => 1
  end

  def down
    remove_column :emisors, :numero_turnos_fisiatria, :integer
  end
end

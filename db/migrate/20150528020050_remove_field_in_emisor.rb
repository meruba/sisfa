class RemoveFieldInEmisor < ActiveRecord::Migration
  def up
    remove_column :emisors, :numero_turnos_fisiatria
  end

  def down
    add_column :emisors, :numero_turnos_fisiatria, :integer, default: 1
  end
end

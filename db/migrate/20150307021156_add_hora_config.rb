class AddHoraConfig < ActiveRecord::Migration

  def up
    add_column :emisors, :numero_turnos_fisiatria, :integer
  end

  def down
    remove_column :emisors, :numero_turnos_fisiatria
  end

end

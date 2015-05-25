class AddAltaAsignarHorario < ActiveRecord::Migration
  def up
    add_column :asignar_horarios, :alta, :boolean, default: false
  end

  def down
    remove_column :asignar_horarios, :alta
  end
end

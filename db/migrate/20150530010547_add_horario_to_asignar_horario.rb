class AddHorarioToAsignarHorario < ActiveRecord::Migration
  def up
    add_reference :asignar_horarios, :horario, index: true
  end
  def down
    remove_reference :asignar_horarios, :horario
  end
end

class AddHorarioToAsignarH < ActiveRecord::Migration
  def change
   	add_reference :asignar_horarios, :horario,  index: true
  end
end

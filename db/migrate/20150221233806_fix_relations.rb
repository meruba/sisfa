class FixRelations < ActiveRecord::Migration
  def up
    add_reference :resultado_tratamientos, :horario
    remove_reference :asignar_horarios, :horario
  end
  def down
    remove_reference :resultado_tratamientos, :horario
    radd_reference :asignar_horarios, :horario
  end
end

class FixReltaions < ActiveRecord::Migration
  def up
    remove_reference :disponiblidad_horarios, :resultado_tratamiento
    add_column :disponiblidad_horarios, :numero_actual_turnos, :integer
  end

  def down
    add_reference :disponiblidad_horarios, :resultado_tratamiento
    remove_column :disponiblidad_horarios, :numero_actual_turnos
  end
end

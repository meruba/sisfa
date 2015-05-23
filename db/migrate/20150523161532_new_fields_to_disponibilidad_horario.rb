class NewFieldsToDisponibilidadHorario < ActiveRecord::Migration
  def up
    add_column :disponiblidad_horarios, :numero_horarios, :integer
    add_column :disponiblidad_horarios, :turnos_por_dia, :integer
    add_column :disponiblidad_horarios, :config_turnos, :integer
  end

  def down
    remove_column :disponiblidad_horarios, :numero_horarios
    remove_column :disponiblidad_horarios, :turnos_por_dia
    remove_column :disponiblidad_horarios, :config_turnos
  end
end

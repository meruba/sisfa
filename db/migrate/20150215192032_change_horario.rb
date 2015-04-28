class ChangeHorario < ActiveRecord::Migration
  def up
    add_column :horarios, :hora_inicio, :string
    add_column :horarios, :hora_final, :string
    add_column :horarios, :anulado, :boolean, default: false
  end

  def down
    remove_column :horarios, :hora_final
    remove_column :horarios, :hora_inicio
    remove_column :horarios, :anulado
  end
end

class AddDoctorToAsignarHorario < ActiveRecord::Migration
  def up
    add_column :asignar_horarios, :doctor_remitente, :string
  end

  def down
    remove_column :asignar_horarios, :doctor_remitente
  end
end

class AddFieldsToDoctorTurnoAndRegistro < ActiveRecord::Migration
  def change
  	add_column :registros, :especialidad_egreso, :string
    add_column :doctors, :cantidad_turno, :integer
  	change_column :turnos, :hora, :datetime
  end
end

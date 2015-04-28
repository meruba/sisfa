class AgregarRefernciaPaciente < ActiveRecord::Migration
  def change
  	add_reference :asignar_horarios, :paciente, :index => true
  end
end

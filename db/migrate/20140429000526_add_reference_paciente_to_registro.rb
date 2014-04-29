class AddReferencePacienteToRegistro < ActiveRecord::Migration
  def change
  	add_reference :registros, :paciente, index: true
  end
end

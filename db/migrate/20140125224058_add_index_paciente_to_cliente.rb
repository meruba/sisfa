class AddIndexPacienteToCliente < ActiveRecord::Migration
  def change
  	add_index :pacientes, :cliente_id
  end
end

class AddRelationPacienteAndResultadoTratamiento < ActiveRecord::Migration
  def up
    add_reference :resultado_tratamientos, :paciente, index: true
  end
  def down
    remove_reference :resultado_tratamientos, :paciente
  end
end

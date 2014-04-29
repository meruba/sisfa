class AddHistoriaCLinicaToPaciente < ActiveRecord::Migration
  def change
  	add_column :pacientes, :n_hclinica, :integer
  	add_column :pacientes, :fecha_hclinica, :date
  end
end

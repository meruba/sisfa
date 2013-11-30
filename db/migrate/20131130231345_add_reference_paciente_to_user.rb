class AddReferencePacienteToUser < ActiveRecord::Migration
  def up
  	change_table :pacientes do |t|
  		t.references :cliente, :null => false
  	end
  end
  def down
  	remove_column :pacientes, :cliente_id
  end
end

class AddReferencePacienteToPersona < ActiveRecord::Migration
  def up
  	change_table :pacientes do |t|
  		t.references :persona, :null => false
  end
  end
  
  def down
  	remove column :pacientes, :persona_id
  end
end

class DeleteReferencePersonaToPaciente < ActiveRecord::Migration
  def up
  	remove_column :pacientes, :persona_id
  end
  def down
  	add_column :pacientes, :persona_id
  end
end

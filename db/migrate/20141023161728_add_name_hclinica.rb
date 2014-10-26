class AddNameHclinica < ActiveRecord::Migration
  def up
  	add_column :pacientes, :registrado_por, :string
  end
  def down
  	remove_column :pacientes, :registrado_por
  end
end

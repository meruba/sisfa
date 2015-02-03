class NewFieldsPaciente < ActiveRecord::Migration
  def up
  	add_column :clientes, :ocupacion, :string, :default => ""
  	add_column :informacion_adicional_pacientes, :representante_legal, :string, :default => ""
  end
  def down
  	remove_column :clientes, :ocupacion
  	remove_column :informacion_adicional_pacientes, :representante_legal
  end
end

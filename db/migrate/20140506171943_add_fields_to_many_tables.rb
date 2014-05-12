class AddFieldsToManyTables < ActiveRecord::Migration
  def change
    add_column :informacion_adicional_pacientes, :nacionalidad, :string
    add_column :informacion_adicional_pacientes, :raza, :string
    rename_column :informacion_adicional_pacientes, :ciudad, :parroquia
    add_column :informacion_adicional_pacientes, :familiar_parentesco, :string
    add_column :registros, :tipo, :string	
    add_column :registros, :condicion_egreso, :string	
    add_column :registros, :diagnostico_sec_egreso1, :string	
    add_column :registros, :diagnostico_sec_egreso2, :string	
    add_column :registros, :codigo_cie, :string	
  end
end

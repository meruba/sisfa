class FixedSomeFields < ActiveRecord::Migration
  def change
  	remove_column :informacion_adicional_pacientes, :jefe_de_reparto
  	add_column :pacientes, :jefe_de_reparto, :string
  	add_column :condicions, :tipo_registro, :string
  	change_column :consulta_externa_morbilidads, :inicio_atencion, :datetime
  	change_column :consulta_externa_morbilidads, :fin_atencion, :datetime
  	change_column :consulta_externa_preventivas, :inicio_atencion, :datetime
  	change_column :consulta_externa_preventivas, :fin_atencion, :datetime
  end
end

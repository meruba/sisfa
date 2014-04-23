class CreateInformacionAdicionalPacientes < ActiveRecord::Migration
  def change
    create_table :informacion_adicional_pacientes do |t|
    	t.string :ciudad
    	t.string :provincia
    	t.string :canton
    	t.string :jefe_de_reparto
    	t.string :familiar_cercano
    	t.string :familiar_direccion
    	t.string :familiar_telefono
    	t.string :observacion
    	t.references :paciente, index: true
      t.timestamps
    end
  end
end

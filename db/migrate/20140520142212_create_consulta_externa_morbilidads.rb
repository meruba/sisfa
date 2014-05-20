class CreateConsultaExternaMorbilidads < ActiveRecord::Migration
  def change
    create_table :consulta_externa_morbilidads do |t|
    	t.references :condicion, index: true
    	t.references :paciente, index: true
    	t.references :doctor, index: true
    	t.string :nombre_medico
    	t.string :tipo_de_atencion
    	t.string :grupos_de_edad
      t.string :diagnostico_sindrome
    	t.string :codigo_cie
    	t.string :condicion_diagnostico
    	t.string :ordenes
    	t.boolean :certificado_medico
    	t.time :inicio_atencion
    	t.time :fin_atencion
    	t.time :horas_trabajadas
      t.timestamps
    end
  end
end

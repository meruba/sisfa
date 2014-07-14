class CreateConsultaExternaPreventivas < ActiveRecord::Migration
  def change
    create_table :consulta_externa_preventivas do |t|
    	t.references :condicion, index: true
    	t.references :paciente, index: true
    	t.references :doctor, index: true
    	t.string :nombre_medico
    	t.string :atencion_preventiva
    	t.string :prenatal
    	t.string :tipo_de_atencion
    	t.boolean :partos
    	t.boolean :post_partos
    	t.string :planificacion_familiar
    	t.string :doc
    	t.boolean :certificado_medico
    	t.boolean :trabajadora_sexual
    	t.string :grupos_de_edad
    	t.time :inicio_atencion
    	t.time :fin_atencion
    	t.time :horas_trabajadas
      t.timestamps
    end
  end
end

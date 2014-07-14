class CreateJornadaMorbilidads < ActiveRecord::Migration
  def change
    create_table :jornada_morbilidads do |t|
    	t.datetime :inicio_atencion
  		t.datetime :fin_atencion  		
  		t.datetime :horas_trabajadas  		
  		t.references :doctor, index: true
      t.integer :total_discapacitados, default: 0
  		t.integer :total_hombre, default: 0
  		t.integer :total_mujer, default: 0
  		t.integer :total_blanco, default: 0
  		t.integer :total_mestizo, default: 0
  		t.integer :total_afroecuatoriano, default: 0
  		t.integer :total_indigena, default: 0
  		t.integer :total_montubio, default: 0
  		t.integer :total_colombiano, default: 0
  		t.integer :total_peruano, default: 0
  		t.integer :total_otra_nacionalidad, default: 0
  		t.integer :total_iess, default: 0
  		t.integer :total_issfa, default: 0
  		t.integer :total_ispol, default: 0
  		t.integer :total_otros_seguros, default: 0
  		t.integer :total_aerea, default: 0
  		t.integer :total_naval, default: 0
  		t.integer :total_terrestre, default: 0
  		t.integer :total_activo, default: 0
  		t.integer :total_pasivo, default: 0
  		t.integer :total_aspirante, default: 0
  		t.integer :total_conscripto, default: 0
			t.integer :total_activo_familiar, default: 0
  		t.integer :total_pasivo_familiar, default: 0
  		t.integer :total_derecho_hab, default: 0
  		t.integer :total_civilies, default: 0
  		t.integer :total_atencion_primera, default: 0
  		t.integer :total_atencion_subsecuente, default: 0
  		t.integer :total_atencion_interconsulta, default: 0
  		t.integer :total_memor_1_mes, default: 0
  		t.integer :total_memor_1_11_mes, default: 0
  		t.integer :total_1_4_anios, default: 0
  		t.integer :total_5_9_anios, default: 0
  		t.integer :total_10_44_anios, default: 0
  		t.integer :total_15_19_anios, default: 0
  		t.integer :total_20_49_anios, default: 0
  		t.integer :total_50_64_anios, default: 0
  		t.integer :total_65_anios, default: 0
  		t.integer :total_presuntivo, default: 0
  		t.integer :total_inicial, default: 0
  		t.integer :total_control, default: 0
  		t.integer :total_interconsulta, default: 0
  		t.integer :total_referencia, default: 0
  		t.integer :total_certificado_medico, default: 0
      t.timestamps
    end
  end
end

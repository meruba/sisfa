class CreateEmergenciaParteMensuals < ActiveRecord::Migration
  def change
    create_table :emergencia_parte_mensuals do |t|
   		t.references :doctor, index: true
			t.integer :total_hombre, default: 0
  		t.integer :total_mujer, default: 0
  		t.integer :total_aerea, default: 0
  		t.integer :total_naval, default: 0
  		t.integer :total_terrestre, default: 0
  		t.integer :total_militar_sa, default: 0
  		t.integer :total_militar_sp, default: 0
  		t.integer :total_militar_asp, default: 0
  		t.integer :total_militar_cpto, default: 0
  		t.integer :total_familiar_sa, default: 0
  		t.integer :total_familiar_sp, default: 0
  		t.integer :total_familiar_hab, default: 0
  		t.integer :total_civil_convenio, default: 0
  		t.integer :total_civil_particular, default: 0
  		t.integer :total_memor_1_anio, default: 0
  		t.integer :total_1_4_anios, default: 0
  		t.integer :total_5_9_anios, default: 0
  		t.integer :total_10_44_anios, default: 0
  		t.integer :total_15_19_anios, default: 0
  		t.integer :total_20_49_anios, default: 0
  		t.integer :total_50_64_anios, default: 0
  		t.integer :total_65_anios, default: 0
  		t.integer :total_atencion_clinico, default: 0
  		t.integer :total_atencion_quirurjico, default: 0
  		t.integer :total_atencion_obstetrico, default: 0
  		t.integer :total_atencion_traumatologia, default: 0
  		t.integer :total_accidente, default: 0
  		t.integer :total_envenenamiento, default: 0
  		t.integer :total_violencia, default: 0
  		t.integer :total_otras, default: 0
  		t.integer :total_destino_alta, default: 0
  		t.integer :total_destino_consulta, default: 0
  		t.integer :total_destino_observacion, default: 0
  		t.integer :total_destino_internamiento, default: 0
  		t.integer :total_destino_tr_sal, default: 0
  		t.integer :total_destino_tr_nom, default: 0
      t.timestamps
    end
  end
end

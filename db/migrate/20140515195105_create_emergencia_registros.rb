class CreateEmergenciaRegistros < ActiveRecord::Migration
  def change
    create_table :emergencia_registros do |t|
    	t.references :condicion, index: true
    	t.references :paciente, index: true
    	t.references :doctor, index: true
    	t.string :nombre_medico
    	t.string :especialidad
    	t.string :tipo_usuario
    	t.string :atencion
    	t.string :causa
    	t.string :destino
    	t.string :diagnostico
    	t.string :condicion_salir
    	t.string :grupos_etareos
      t.boolean :registrado, default: false
      t.timestamps
    end
  end
end

class CreateCondicions < ActiveRecord::Migration
  def change
    create_table :condicions do |t|
    	t.references :paciente, index: true
    	t.references :doctor, index: true
    	t.string :medico_asignado
    	t.string :antecedentes_personales
    	t.string :antecedentes_familiares
    	t.string :enfermedad_actual
    	t.string :revision_organos_sistema
    	t.string :presion_arterial
    	t.string :pulso
    	t.string :temperatua
    	t.string :examen_fisico
    	t.string :diagnostico_1
    	t.string :diagnostico_2
    	t.string :planes
      t.timestamps
    end
  end
end

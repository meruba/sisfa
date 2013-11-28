class CreatePacientes < ActiveRecord::Migration
  def change
    create_table :pacientes do |t|
    	t.integer :n_hclinica
    	t.date :fecha_de_ingreso
    	t.date :hora_de_ingreso
    	t.string :pertenece
    	t.string :sexo
    	t.date :fecha_de_nacimiento
    	t.string :estado_civil
    	t.string :grado
    	t.string :familiar
    	t.string :brigada
    	t.string :tipo_de_paciente
      t.timestamps
    end
  end
end

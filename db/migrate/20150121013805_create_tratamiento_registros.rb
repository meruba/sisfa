class CreateTratamientoRegistros < ActiveRecord::Migration
  def change
    create_table :tratamiento_registros do |t|
    	t.string :nombre_tratamiento
    	t.references :asignar_horario, index: true	
    	t.references :tratamiento, index: true	
      t.timestamps
    end
  end
end

class CreateAsignacionCamas < ActiveRecord::Migration
  def change
    create_table :asignacion_camas do |t|
    	t.references :cama, index: true
    	t.references :hospitalizacion_registro, index: true
    	t.string :numero_cama
      t.timestamps
    end
  end
end

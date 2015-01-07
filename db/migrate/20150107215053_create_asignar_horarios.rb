class CreateAsignarHorarios < ActiveRecord::Migration
  def change
    create_table :asignar_horarios do |t|
    	t.integer :numero_terapias
    	t.datetime :fecha_inicio
    	t.datetime :fecha_final
    	t.references :item_tratamiento, index: true
      t.timestamps
    end
  end
end

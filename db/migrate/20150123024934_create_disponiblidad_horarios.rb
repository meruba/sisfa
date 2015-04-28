class CreateDisponiblidadHorarios < ActiveRecord::Migration
  def change
    create_table :disponiblidad_horarios do |t|
    	t.boolean :lleno, default: false
    	t.references :resultado_tratamiento, index: true	
    	t.datetime :dia	
      t.timestamps
    end
  end
end

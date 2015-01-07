class CreateAsignarHorarioExternos < ActiveRecord::Migration
  def change
    create_table :asignar_horario_externos do |t|
    	t.references :paciente, index: true
    	t.references :item_tratamiento, index: true
    	t.string :diagnostico
    	t.references :asignar_horario, index: true
      t.timestamps
    end
  end
end

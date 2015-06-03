class CreateFisiatriaConfiguracions < ActiveRecord::Migration
  def change
    create_table :fisiatria_configuracions do |t|
      t.integer :numero_turnos
      t.string :encargado_departamento
      t.string :grado_director
      t.text :respuesta_tratamiento
      t.timestamps
    end
  end
end

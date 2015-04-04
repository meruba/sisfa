class CreateNecesitaTerapia < ActiveRecord::Migration
  def change
    create_table :necesita_terapia do |t|
      t.references :paciente, index: true
      t.references :consulta_externa_morbilidad, index: true
      t.boolean :enviar_fisiatria, default: false
      t.timestamps
    end
  end
end

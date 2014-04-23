class CreatePacientes < ActiveRecord::Migration
  def change
    create_table :pacientes do |t|
    	t.string :tipo
    	t.string :grado
    	t.string :estado
    	t.string :codigo_issfa
    	t.string :pertenece_a
    	t.string :unidad
    	t.string :parentesco
    	t.references :cliente, :index => true
      t.timestamps
    end
  end
end

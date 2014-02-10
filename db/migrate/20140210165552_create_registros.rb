class CreateRegistros < ActiveRecord::Migration
  def change
    create_table :registros do |t|
    	t.integer :n_hclinica, :null => false
      t.datetime :fecha_de_ingreso, :null => false
      t.datetime :fecha_de_salida
      t.string :especialidad, :null => false
      t.string :medico_asignado
      t.references :cliente, index: true
      t.timestamps
    end
  end
end

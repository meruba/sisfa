class CreateResultadoTratamientos < ActiveRecord::Migration
  def change
    create_table :resultado_tratamientos do |t|
    	t.references :personal, index: true
    	t.string :resultado
      t.timestamps
    end
  end
end

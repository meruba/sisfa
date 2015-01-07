class CreateResultadoTratamientos < ActiveRecord::Migration
  def change
    create_table :resultado_tratamientos do |t|

      t.timestamps
    end
  end
end

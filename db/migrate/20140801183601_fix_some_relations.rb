class FixSomeRelations < ActiveRecord::Migration
  def change
  	add_column :hospitalizacion_registros, :alta_enfermeria, :boolean, default: false
  	add_reference :hospitalizacions, :hospitalizacion_registro, index: true
  	remove_column :hospitalizacions, :cliente_id
  	remove_column :hospitalizacions, :dado_de_alta
  end
end

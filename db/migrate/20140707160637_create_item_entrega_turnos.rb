class CreateItemEntregaTurnos < ActiveRecord::Migration
  def change
    create_table :item_entrega_turnos do |t|
			t.references :entrega_turno, index: true
    	t.references :hospitalizacion_registro, index: true
    	t.references :user, index: true
    	t.string :tipo_item
    	t.string :descripcion
      t.timestamps
    end
  end
end

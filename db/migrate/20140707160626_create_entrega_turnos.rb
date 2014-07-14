class CreateEntregaTurnos < ActiveRecord::Migration
  def change
    create_table :entrega_turnos do |t|
			t.string :servicio
    	t.datetime :fecha
      t.timestamps
    end
  end
end

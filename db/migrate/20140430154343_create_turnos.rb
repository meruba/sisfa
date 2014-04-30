class CreateTurnos < ActiveRecord::Migration
  def change
    create_table :turnos do |t|
    	t.datetime :fecha
    	t.time :hora
    	t.string :doctor
    	t.boolean :atendido, default: false
    	t.references :paciente, index: true
      t.timestamps
    end
  end
end

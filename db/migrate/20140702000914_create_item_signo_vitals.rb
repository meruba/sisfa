class CreateItemSignoVitals < ActiveRecord::Migration
  def change
    create_table :item_signo_vitals do |t|
    	t.references :signo_vital, index: true
    	t.references :user, index: true
    	t.datetime :fecha
    	t.datetime :hora
    	t.string :temperatura
    	t.string :pulso
    	t.string :respiracion
    	t.string :tension_arterial
    	t.string :observacion
      t.timestamps
    end
  end
end

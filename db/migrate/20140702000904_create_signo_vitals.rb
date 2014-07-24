class CreateSignoVitals < ActiveRecord::Migration
  def change
    create_table :signo_vitals do |t|
			t.references :hospitalizacion_registro, index: true
      t.timestamps
    end
  end
end

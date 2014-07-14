class CreateNotaEnfermeras < ActiveRecord::Migration
  def change
    create_table :nota_enfermeras do |t|
    	t.references :hospitalizacion, index: true
      t.timestamps
    end
  end
end

class CreateItemNotaEnfermeras < ActiveRecord::Migration
  def change
    create_table :item_nota_enfermeras do |t|
    	t.references :nota_enfermera, index: true
    	t.datetime :fecha
    	t.datetime :hora
    	t.string :nota
      t.timestamps
    end
  end
end

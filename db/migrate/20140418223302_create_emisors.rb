class CreateEmisors < ActiveRecord::Migration
  def change
    create_table :emisors do |t|
      t.string :nombre_establecimiento
      t.string :ruc
      t.integer :numero_inicial_factura
      t.timestamps
      t.timestamps
    end
  end
end

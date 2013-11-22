class CreateFacturas < ActiveRecord::Migration
  def change
    create_table :facturas do |t|
      t.integer :numero, :null => false
      t.string :observacion
      t.datetime :fecha_de_emision, :null => false
      t.datetime :fecha_de_vencimiento, :null => false
      t.float :subtotal_0, :null => false
      t.float :subtotal_12, :null => false
      t.float :descuento, :null => false
      t.float :iva, :null => false
      t.float :total, :null => false
      t.timestamps
    end
  end
end

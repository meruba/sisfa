class CreateFacturaCompras < ActiveRecord::Migration
  def change
    create_table :factura_compras do |t|
      t.references :proveedor, :index => true
      t.references :user, :index => true
      t.integer :numero
      t.string :observacion
      t.datetime :fecha_de_emision
      t.datetime :fecha_de_vencimiento
      t.float :subtotal_0, :null => false
      t.float :subtotal_12, :null => false
      t.float :descuento, :null => false
      t.float :iva, :null => false
      t.float :total, :null => false
      t.timestamps
    end
  end
end

class CreateIngresoProductos < ActiveRecord::Migration
  def change
    create_table :ingreso_productos do |t|
      t.string :lote
      t.date :fecha_caducidad
      t.decimal :precio_compra, precision: 4, scale: 2, null: false
      t.decimal :precio_venta, precision: 4, scale: 2
      t.integer :cantidad
      t.float :ganancia
      t.references :producto, index: true
      t.timestamps
    end
  end
end

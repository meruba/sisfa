class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :nombre, :null => false
      t.float :precio, :null => false
      t.string :codigo
      t.string :categoria
      t.string :descripcion
      t.date :fecha_de_caducidad
      t.string :casa_comercial
    end
  end
end

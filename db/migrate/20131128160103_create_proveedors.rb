class CreateProveedors < ActiveRecord::Migration
  def change
    create_table :proveedors do |t|
      t.string :nombre_o_razon_social, :null=>false
      t.string :codigo, :null=>false
      t.string :direccion
      t.string :telefono
      t.string :ciudad
      t.string :numero_de_identifficacion, :null=>false
      t.string :pais
      t.string :representante_legal
      t.string :fax
      t.timestamps
    end
  end
end

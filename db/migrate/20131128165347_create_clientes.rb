class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nombre
      t.string :direccion
      t.string :numero_de_identificacion
      t.string :telefono
      t.string :email

      t.timestamps
    end
  end
end

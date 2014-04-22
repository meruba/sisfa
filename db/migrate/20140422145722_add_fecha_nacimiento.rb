class AddFechaNacimiento < ActiveRecord::Migration
  def change
  	add_column :clientes, :fecha_de_nacimiento, :date
  end
end

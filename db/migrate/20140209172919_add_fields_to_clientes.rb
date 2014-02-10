class AddFieldsToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :sexo, :string
    add_column :clientes, :edad, :integer
    add_column :clientes, :estado_civil, :string
  end
end

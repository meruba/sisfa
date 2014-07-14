class AddClienteToDoctor < ActiveRecord::Migration
  def change
    add_reference :doctors, :cliente, index: true
    remove_column :doctors, :nombre
  end
end

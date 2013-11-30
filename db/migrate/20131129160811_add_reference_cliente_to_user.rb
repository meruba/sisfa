class AddReferenceClienteToUser < ActiveRecord::Migration
  def change
    add_column :users, :cliente_id, :string
  end
end

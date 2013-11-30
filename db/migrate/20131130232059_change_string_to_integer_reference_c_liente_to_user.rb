class ChangeStringToIntegerReferenceCLienteToUser < ActiveRecord::Migration
  def up
    remove_column :users, :cliente_id
    add_column :users, :cliente_id, :integer
  end
end

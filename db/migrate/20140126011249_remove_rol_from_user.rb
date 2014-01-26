class RemoveRolFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :rol
  end
end

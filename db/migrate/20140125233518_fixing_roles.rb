class FixingRoles < ActiveRecord::Migration
  def up
    remove_column :users, :rol
  end

  def down
    add_column :users, :rol, :string
  end
end

class AddFieldSuspenderToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :suspendido, :boolean, :default => false
  end
end

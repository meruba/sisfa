class AddSuspendidoToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :suspendido, :boolean, default: false
  end
end

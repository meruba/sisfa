class AddSuspendidoItemTratamiento < ActiveRecord::Migration
  def up
    add_column :item_tratamientos, :suspendido, :boolean, default: false
  end

  def down
    remove_column :item_tratamientos, :suspendido
  end
end

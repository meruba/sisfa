class AgregarClienteIdEnLaBaseDeDatos < ActiveRecord::Migration

  def up
    add_column :proformas, :cliente_id, :float, :null => false
  end
  def down
    remove_column :proformas, :cliente_id 
  end
end

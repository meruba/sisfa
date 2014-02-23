class ChangeRelationships < ActiveRecord::Migration
  def change
    remove_column :item_facturas, :producto_id
    remove_column :item_proformas, :producto_id
    remove_column :item_traspasos, :producto_id
    
    add_column :item_facturas, :ingreso_productos_id, :integer
    add_index :item_facturas, :ingreso_productos_id
    
    add_column :item_proformas, :ingreso_productos_id, :integer
    add_index :item_proformas, :ingreso_productos_id

    add_column :item_traspasos, :ingreso_productos_id, :integer
    add_index :item_traspasos, :ingreso_productos_id
  end
end

class ChangeRelationships < ActiveRecord::Migration
  def change
    remove_column :item_facturas, :producto_id
    remove_column :item_proformas, :producto_id
    remove_column :item_traspasos, :producto_id

    add_column :item_facturas, :ingreso_producto_id, :integer
    add_index :item_facturas, :ingreso_producto_id

    add_column :item_proformas, :ingreso_producto_id, :integer
    add_index :item_proformas, :ingreso_producto_id

    add_column :item_traspasos, :ingreso_producto_id, :integer
    add_index :item_traspasos, :ingreso_producto_id
  end
end

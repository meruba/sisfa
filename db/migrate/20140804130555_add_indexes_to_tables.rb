class AddIndexesToTables < ActiveRecord::Migration
  def change
    add_index :canjes, :antiguo_id
    add_index :canjes, :nuevo_id
    add_index :canjes, :producto_id
    add_index :factura_compras_productos, :factura_compra_id
    add_index :factura_compras_productos, :producto_id
    add_index :facturas, :proveedor_id
    add_index :facturas, :cliente_id
    add_index :item_facturas, :factura_id
    add_index :item_proformas, :proforma_id
    add_index :kardexes, :producto_id
    add_index :lineakardexes, :kardex_id
    add_index :proformas, :cliente_id
    add_index :users, :cliente_id
  end
end

class AgregarCamposAitemProformas < ActiveRecord::Migration
  def up
    add_column :item_proformas, :cantidad, :float, :null => false
    add_column :item_proformas, :valor_unitario, :float, :null => false
    add_column :item_proformas, :descuento, :float
    add_column :item_proformas, :iva, :float
    add_column :item_proformas, :producto_id, :integer, :null => false
    add_column :item_proformas, :proforma_id, :integer, :null => false

  end
  def down
    remove_column :item_proformas, :cantidad
    remove_column :item_proformas, :valor_unitario
    remove_column :item_proformas, :descuento
    remove_column :item_proformas, :iva
    remove_column :item_proformas, :producto_id
    remove_column :item_proformas, :proforma_id
  end
end

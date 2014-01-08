class AgregarTotalAlItemProforma < ActiveRecord::Migration
  def up
    add_column :item_proformas, :total, :float, :null => false
  end
  def down
    remove_column :item_proformas, :total 
  end
end

class RemoveIvaFromItemTraspasos < ActiveRecord::Migration
  def change
    remove_column :item_traspasos, :iva
  end
end

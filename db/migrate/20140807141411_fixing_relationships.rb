class FixingRelationships < ActiveRecord::Migration
  def change
    remove_column :cierre_cajas, :factura_id
  end
end

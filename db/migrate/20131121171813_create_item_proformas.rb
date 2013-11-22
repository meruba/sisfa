class CreateItemProformas < ActiveRecord::Migration
  def change
    create_table :item_proformas do |t|
    	t.references :itemFactura

      t.timestamps
    end
  end
end

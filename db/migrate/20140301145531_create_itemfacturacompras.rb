class CreateItemfacturacompras < ActiveRecord::Migration
  def change
    create_table :itemfacturacompras do |t|
      t.references :producto, index: true
      t.references :factura, index: true

      t.timestamps
    end
  end
end

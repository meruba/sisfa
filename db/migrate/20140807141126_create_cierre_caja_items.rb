class CreateCierreCajaItems < ActiveRecord::Migration
  def change
    create_table :cierre_caja_items do |t|
      t.references :factura, index: true
      t.references :cierre_caja, index: true

      t.timestamps
    end
  end
end

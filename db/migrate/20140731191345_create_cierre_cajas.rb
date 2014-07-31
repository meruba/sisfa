class CreateCierreCajas < ActiveRecord::Migration
  def change
    create_table :cierre_cajas do |t|
      t.references :user, index: true
      t.references :factura, index: true
      t.boolean :is_cerrado

      t.timestamps
    end
  end
end

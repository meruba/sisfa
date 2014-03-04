class AddTableProductosFacturaCompras < ActiveRecord::Migration
  def change
    create_table :factura_compras_productos do |t|
      t.belongs_to :factura_compra
      t.belongs_to :producto
    end
  end
end

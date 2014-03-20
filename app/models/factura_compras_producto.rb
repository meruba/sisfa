# == Schema Information
#
# Table name: factura_compras_productos
#
#  id                :integer          not null, primary key
#  factura_compra_id :integer
#  producto_id       :integer
#

class FacturaComprasProducto < ActiveRecord::Base
  belongs_to :producto
  belongs_to :factura_compra
  accepts_nested_attributes_for :producto
end

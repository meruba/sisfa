# == Schema Information
#
# Table name: factura_compras_productos
#
#  id                :integer          not null, primary key
#  factura_compra_id :integer
#  producto_id       :integer
#  cantidad          :float            not null
#  valor_unitario    :float            not null
#  iva               :float            not null
#  total             :float            not null
#

require 'test_helper'

class FacturaComprasProductoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

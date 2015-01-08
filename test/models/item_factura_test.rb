# == Schema Information
#
# Table name: item_facturas
#
#  id                  :integer          not null, primary key
#  cantidad            :integer          not null
#  valor_unitario      :float            not null
#  descuento           :float
#  iva                 :float            not null
#  total               :float            not null
#  created_at          :datetime
#  updated_at          :datetime
#  factura_id          :integer          not null
#  tipo                :string(255)
#  ingreso_producto_id :integer
#

require 'test_helper'

class ItemFacturaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

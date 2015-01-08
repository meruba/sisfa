# == Schema Information
#
# Table name: factura_compras
#
#  id                   :integer          not null, primary key
#  proveedor_id         :integer
#  user_id              :integer
#  numero               :integer
#  observacion          :string(255)
#  fecha_de_emision     :datetime
#  fecha_de_vencimiento :datetime
#  subtotal_0           :float            not null
#  iva                  :float            not null
#  total                :float            not null
#  created_at           :datetime
#  updated_at           :datetime
#  subtotal_12          :float
#

require 'test_helper'

class FacturaCompraTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

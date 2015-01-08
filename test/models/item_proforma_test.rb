# == Schema Information
#
# Table name: item_proformas
#
#  id                  :integer          not null, primary key
#  created_at          :datetime
#  updated_at          :datetime
#  cantidad            :float            not null
#  valor_unitario      :float            not null
#  descuento           :float
#  iva                 :float
#  proforma_id         :integer          not null
#  total               :float            not null
#  ingreso_producto_id :integer
#

require 'test_helper'

class ItemProformaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

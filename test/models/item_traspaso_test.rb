# == Schema Information
#
# Table name: item_traspasos
#
#  id                  :integer          not null, primary key
#  cantidad            :float            not null
#  valor_unitario      :float            not null
#  total               :float            not null
#  created_at          :datetime
#  updated_at          :datetime
#  traspaso_id         :integer
#  ingreso_producto_id :integer
#  iva                 :float
#

require 'test_helper'

class ItemTraspasoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

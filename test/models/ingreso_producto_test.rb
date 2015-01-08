# == Schema Information
#
# Table name: ingreso_productos
#
#  id              :integer          not null, primary key
#  lote            :string(255)
#  fecha_caducidad :date
#  cantidad        :integer
#  producto_id     :integer
#  created_at      :datetime
#  updated_at      :datetime
#

require 'test_helper'

class IngresoProductoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: productos
#
#  id              :integer          not null, primary key
#  nombre          :string(255)      not null
#  codigo          :string(255)
#  categoria       :string(255)
#  casa_comercial  :string(255)
#  nombre_generico :string(255)
#  precio_compra   :decimal(4, 2)    not null
#  precio_venta    :decimal(4, 2)    not null
#  ganancia        :decimal(4, 2)    not null
#  hasiva          :boolean          default(FALSE)
#  stock           :integer          default(0), not null
#

require 'test_helper'

class ProductoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

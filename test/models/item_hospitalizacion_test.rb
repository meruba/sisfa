# == Schema Information
#
# Table name: item_hospitalizacions
#
#  id                  :integer          not null, primary key
#  cantidad            :float            not null
#  valor_unitario      :float            not null
#  iva                 :float            not null
#  total               :float            not null
#  descuento           :float
#  created_at          :datetime
#  updated_at          :datetime
#  hospitalizacion_id  :integer
#  ingreso_producto_id :integer
#  pedido_por          :string(255)
#  despachado_por      :string(255)
#  despachado          :boolean          default(FALSE)
#  razon_anulada       :string(255)
#  anulado             :boolean          default(FALSE)
#

require 'test_helper'

class ItemHospitalizacionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

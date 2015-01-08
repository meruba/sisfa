# == Schema Information
#
# Table name: facturas
#
#  id                   :integer          not null, primary key
#  numero               :integer          not null
#  observacion          :string(255)
#  fecha_de_emision     :datetime         not null
#  fecha_de_vencimiento :datetime         not null
#  subtotal_0           :float            not null
#  subtotal_12          :float            not null
#  descuento            :float            not null
#  iva                  :float            not null
#  total                :float            not null
#  created_at           :datetime
#  updated_at           :datetime
#  tipo                 :string(255)      not null
#  anulada              :boolean          default(FALSE)
#  proveedor_id         :integer
#  cliente_id           :integer
#  user_id              :integer
#  razon_anulada        :string(255)
#

require 'test_helper'

class FacturaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: liquidacions
#
#  id                            :integer          not null, primary key
#  iva_ventanilla                :decimal(8, 2)    default(0.0), not null
#  iva_hospitalizacion           :decimal(8, 2)    default(0.0), not null
#  iva_traspaso                  :decimal(8, 2)    default(0.0), not null
#  iva_compra                    :decimal(8, 2)    default(0.0), not null
#  subtotal_ventanilla           :decimal(8, 2)    default(0.0), not null
#  subtotal_hospitalizacion      :decimal(8, 2)    default(0.0), not null
#  subtotal_traspaso             :decimal(8, 2)    default(0.0), not null
#  subtotal_compra               :decimal(8, 2)    default(0.0), not null
#  total_ventanilla              :decimal(8, 2)    default(0.0), not null
#  total_hospitalizacion         :decimal(8, 2)    default(0.0), not null
#  total_traspaso                :decimal(8, 2)    default(0.0), not null
#  total_compra                  :decimal(8, 2)    default(0.0), not null
#  emitidos_ventanilla           :integer          default(0)
#  emitidos_hospitalizacion      :integer          default(0)
#  emitidos_traspaso             :integer          default(0)
#  emitidos_compra               :integer          default(0)
#  fecha                         :date
#  created_at                    :datetime
#  updated_at                    :datetime
#  subtotal12_ventanilla         :decimal(8, 2)    default(0.0), not null
#  subtotal12_hospitalizacion    :decimal(8, 2)    default(0.0), not null
#  subtotal12_traspaso           :decimal(8, 2)    default(0.0), not null
#  subtotal12_venta              :decimal(8, 2)    default(0.0), not null
#  subtotal_venta                :decimal(8, 2)    default(0.0), not null
#  iva_venta                     :decimal(8, 2)    default(0.0), not null
#  total_venta                   :decimal(8, 2)    default(0.0), not null
#  subtotal12_compra             :decimal(8, 2)    default(0.0), not null
#  anulados_ventanilla           :integer          default(0)
#  total_sin_iva_ventanilla      :decimal(8, 2)    default(0.0), not null
#  total_sin_iva_hospitalizacion :decimal(8, 2)    default(0.0), not null
#  total_sin_iva_traspaso        :decimal(8, 2)    default(0.0), not null
#  total_sin_iva_compra          :decimal(8, 2)    default(0.0), not null
#  total_sin_iva_venta           :decimal(8, 2)    default(0.0), not null
#  saldo_anterior                :decimal(9, 2)    default(0.0), not null
#  saldo_final                   :decimal(9, 2)    default(0.0), not null
#  costo_venta                   :decimal(9, 2)    default(0.0), not null
#  utilidad                      :decimal(9, 2)    default(0.0), not null
#

require 'test_helper'

class LiquidacionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: emisors
#
#  id                       :integer          not null, primary key
#  nombre_establecimiento   :string(255)
#  ruc                      :string(255)
#  numero_inicial_factura   :integer
#  created_at               :datetime
#  updated_at               :datetime
#  saldo_inicial_inventario :float
#  otros_dias               :boolean          default(FALSE)
#  numero_turnos_fisiatria  :integer
#

require 'test_helper'

class EmisorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

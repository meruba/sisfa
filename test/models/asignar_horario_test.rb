# == Schema Information
#
# Table name: asignar_horarios
#
#  id               :integer          not null, primary key
#  numero_terapias  :integer
#  fecha_inicio     :datetime
#  fecha_final      :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  paciente_id      :integer
#  numero_factura   :integer
#  total_factura    :float            default(0.0)
#  diagnostico      :string(255)
#  doctor_remitente :string(255)
#

require 'test_helper'

class AsignarHorarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: asignar_horarios
#
#  id              :integer          not null, primary key
#  numero_terapias :integer
#  fecha_inicio    :datetime
#  fecha_final     :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  paciente_id     :integer
#

require 'test_helper'

class AsignarHorarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

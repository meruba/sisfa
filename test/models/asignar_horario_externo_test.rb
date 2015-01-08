# == Schema Information
#
# Table name: asignar_horario_externos
#
#  id                  :integer          not null, primary key
#  paciente_id         :integer
#  item_tratamiento_id :integer
#  diagnostico         :string(255)
#  asignar_horario_id  :integer
#  created_at          :datetime
#  updated_at          :datetime
#

require 'test_helper'

class AsignarHorarioExternoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

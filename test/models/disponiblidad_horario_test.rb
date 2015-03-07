# == Schema Information
#
# Table name: disponiblidad_horarios
#
#  id                   :integer          not null, primary key
#  lleno                :boolean          default(FALSE)
#  dia                  :datetime
#  created_at           :datetime
#  updated_at           :datetime
#  numero_actual_turnos :integer
#

require 'test_helper'

class DisponiblidadHorarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

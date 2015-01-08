# == Schema Information
#
# Table name: turnos
#
#  id             :integer          not null, primary key
#  fecha          :datetime
#  hora           :datetime
#  doctor_a_cargo :string(255)
#  atendido       :boolean          default(FALSE)
#  paciente_id    :integer
#  created_at     :datetime
#  updated_at     :datetime
#  doctor_id      :integer
#  numero         :integer          default(0)
#

require 'test_helper'

class TurnoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

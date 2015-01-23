# == Schema Information
#
# Table name: disponiblidad_horarios
#
#  id                       :integer          not null, primary key
#  lleno                    :boolean          default(FALSE)
#  resultado_tratamiento_id :integer
#  dia                      :datetime
#  created_at               :datetime
#  updated_at               :datetime
#

require 'test_helper'

class DisponiblidadHorarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

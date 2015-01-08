# == Schema Information
#
# Table name: asignacion_camas
#
#  id                          :integer          not null, primary key
#  cama_id                     :integer
#  hospitalizacion_registro_id :integer
#  numero_cama                 :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#

require 'test_helper'

class AsignacionCamaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

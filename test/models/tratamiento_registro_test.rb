# == Schema Information
#
# Table name: tratamiento_registros
#
#  id                  :integer          not null, primary key
#  nombre_tratamiento  :string(255)
#  asignar_horario_id  :integer
#  item_tratamiento_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

require 'test_helper'

class TratamientoRegistroTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

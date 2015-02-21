# == Schema Information
#
# Table name: horarios
#
#  id          :integer          not null, primary key
#  hora        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  hora_inicio :string(255)
#  hora_final  :string(255)
#

require 'test_helper'

class HorarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

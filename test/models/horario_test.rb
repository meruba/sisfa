# == Schema Information
#
# Table name: horarios
#
#  id          :integer          not null, primary key
#  hora        :string(255)
#  paciente_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class HorarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: doctors
#
#  id             :integer          not null, primary key
#  especialidad   :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  cantidad_turno :integer
#  suspendido     :boolean          default(FALSE)
#  cliente_id     :integer
#

require 'test_helper'

class DoctorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

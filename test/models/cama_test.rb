# == Schema Information
#
# Table name: camas
#
#  id         :integer          not null, primary key
#  cuarto_id  :integer
#  numero     :integer
#  ocupada    :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CamaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

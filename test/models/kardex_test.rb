# == Schema Information
#
# Table name: kardexes
#
#  id          :integer          not null, primary key
#  fecha       :date
#  created_at  :datetime
#  updated_at  :datetime
#  producto_id :integer          not null
#

require 'test_helper'

class KardexTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

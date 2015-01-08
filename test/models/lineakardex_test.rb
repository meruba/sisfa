# == Schema Information
#
# Table name: lineakardexes
#
#  id            :integer          not null, primary key
#  tipo          :string(255)      not null
#  fecha         :date             not null
#  cantidad      :float            not null
#  v_unitario    :float            not null
#  created_at    :datetime
#  updated_at    :datetime
#  kardex_id     :integer          not null
#  observaciones :string(255)
#  modulo        :string(255)
#

require 'test_helper'

class LineakardexTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

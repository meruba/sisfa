# == Schema Information
#
# Table name: canjes
#
#  id            :integer          not null, primary key
#  antiguo_id    :integer
#  nuevo_id      :integer
#  producto_id   :integer
#  fecha         :datetime
#  created_at    :datetime
#  updated_at    :datetime
#  tipo          :string(255)
#  cantidad      :float            not null
#  precio_salida :float            not null
#  total         :float            not null
#

require 'test_helper'

class CanjeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

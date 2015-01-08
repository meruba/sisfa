# == Schema Information
#
# Table name: item_nota_enfermeras
#
#  id                :integer          not null, primary key
#  nota_enfermera_id :integer
#  user_id           :integer
#  fecha             :datetime
#  hora              :datetime
#  nota              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'

class ItemNotaEnfermeraTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

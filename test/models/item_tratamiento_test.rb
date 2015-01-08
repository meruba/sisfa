# == Schema Information
#
# Table name: item_tratamientos
#
#  id             :integer          not null, primary key
#  codigo         :string(255)
#  nombre         :string(255)
#  tratamiento_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'test_helper'

class ItemTratamientoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

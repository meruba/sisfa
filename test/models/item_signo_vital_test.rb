# == Schema Information
#
# Table name: item_signo_vitals
#
#  id               :integer          not null, primary key
#  signo_vital_id   :integer
#  user_id          :integer
#  fecha            :datetime
#  hora             :datetime
#  temperatura      :string(255)
#  pulso            :string(255)
#  respiracion      :string(255)
#  tension_arterial :string(255)
#  observacion      :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

require 'test_helper'

class ItemSignoVitalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

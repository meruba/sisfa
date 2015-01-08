# == Schema Information
#
# Table name: hospitalizacions
#
#  id                          :integer          not null, primary key
#  fecha_emision               :date             not null
#  numero                      :integer          not null
#  subtotal                    :float            not null
#  iva                         :float            not null
#  total                       :float            not null
#  user_id                     :integer
#  created_at                  :datetime
#  updated_at                  :datetime
#  descuento                   :float
#  subtotal_12                 :float            not null
#  hospitalizacion_registro_id :integer
#

require 'test_helper'

class HospitalizacionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

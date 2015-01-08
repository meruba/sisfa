# == Schema Information
#
# Table name: proformas
#
#  id            :integer          not null, primary key
#  fecha_emision :date             not null
#  numero        :integer          not null
#  iva           :float            not null
#  subtotal_0    :float            not null
#  subtotal_12   :float            not null
#  descuento     :float            not null
#  total         :float            not null
#  created_at    :datetime
#  updated_at    :datetime
#  cliente_id    :integer          not null
#  facturado     :boolean          default(FALSE)
#

require 'test_helper'

class ProformaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

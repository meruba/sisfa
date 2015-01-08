# == Schema Information
#
# Table name: traspasos
#
#  id            :integer          not null, primary key
#  servicio      :string(255)
#  fecha_emision :date             not null
#  numero        :integer          not null
#  iva           :float            not null
#  total         :float            not null
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  subtotal      :float            not null
#  entregado_a   :string(255)
#  subtotal_12   :float            not null
#  razon_anulada :string(255)
#  anulado       :boolean          default(FALSE)
#

require 'test_helper'

class TraspasoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

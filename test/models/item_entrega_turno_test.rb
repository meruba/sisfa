# == Schema Information
#
# Table name: item_entrega_turnos
#
#  id                          :integer          not null, primary key
#  entrega_turno_id            :integer
#  hospitalizacion_registro_id :integer
#  user_id                     :integer
#  tipo_item                   :string(255)
#  descripcion                 :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#

require 'test_helper'

class ItemEntregaTurnoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: necesita_terapia
#
#  id                             :integer          not null, primary key
#  paciente_id                    :integer
#  consulta_externa_morbilidad_id :integer
#  enviar_fisiatria               :boolean          default(FALSE)
#  created_at                     :datetime
#  updated_at                     :datetime
#

require 'test_helper'

class NecesitaTerapiaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

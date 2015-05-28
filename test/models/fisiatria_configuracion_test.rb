# == Schema Information
#
# Table name: fisiatria_configuracions
#
#  id                     :integer          not null, primary key
#  numero_turnos          :integer
#  encargado_departamento :string(255)
#  grado_director         :string(255)
#  respuesta_tratamiento  :text
#  created_at             :datetime
#  updated_at             :datetime
#  cargo_fisiatria        :string(255)
#

require 'test_helper'

class FisiatriaConfiguracionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

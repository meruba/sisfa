# == Schema Information
#
# Table name: consulta_externa_morbilidads
#
#  id                    :integer          not null, primary key
#  condicion_id          :integer
#  paciente_id           :integer
#  doctor_id             :integer
#  nombre_medico         :string(255)
#  tipo_de_atencion      :string(255)
#  grupos_de_edad        :string(255)
#  diagnostico_sindrome  :string(255)
#  codigo_cie            :string(255)
#  condicion_diagnostico :string(255)
#  ordenes               :string(255)
#  certificado_medico    :boolean
#  horas_trabajadas      :time
#  created_at            :datetime
#  updated_at            :datetime
#  turno_id              :integer
#

require 'test_helper'

class ConsultaExternaMorbilidadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

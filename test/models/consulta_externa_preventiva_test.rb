# == Schema Information
#
# Table name: consulta_externa_preventivas
#
#  id                     :integer          not null, primary key
#  condicion_id           :integer
#  paciente_id            :integer
#  doctor_id              :integer
#  nombre_medico          :string(255)
#  atencion_preventiva    :string(255)
#  prenatal               :string(255)
#  tipo_de_atencion       :string(255)
#  partos                 :boolean
#  post_partos            :boolean
#  planificacion_familiar :string(255)
#  doc                    :string(255)
#  certificado_medico     :boolean
#  trabajadora_sexual     :boolean
#  grupos_de_edad         :string(255)
#  horas_trabajadas       :time
#  created_at             :datetime
#  updated_at             :datetime
#  turno_id               :integer
#

require 'test_helper'

class ConsultaExternaPreventivaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

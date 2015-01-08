# == Schema Information
#
# Table name: emergencia_registros
#
#  id              :integer          not null, primary key
#  condicion_id    :integer
#  paciente_id     :integer
#  doctor_id       :integer
#  nombre_medico   :string(255)
#  especialidad    :string(255)
#  tipo_usuario    :string(255)
#  atencion        :string(255)
#  causa           :string(255)
#  destino         :string(255)
#  diagnostico     :string(255)
#  condicion_salir :string(255)
#  grupos_etareos  :string(255)
#  registrado      :boolean          default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'test_helper'

class EmergenciaRegistroTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

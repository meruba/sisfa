# == Schema Information
#
# Table name: pacientes
#
#  id                      :integer          not null, primary key
#  tipo                    :string(255)
#  grado                   :string(255)
#  estado                  :string(255)
#  codigo_issfa            :string(255)
#  pertenece_a             :string(255)
#  unidad                  :string(255)
#  parentesco              :string(255)
#  cliente_id              :integer
#  created_at              :datetime
#  updated_at              :datetime
#  n_hclinica              :integer
#  fecha_hclinica          :date
#  jefe_de_reparto         :string(255)
#  afiliado                :string(255)
#  discapacidad            :string(255)
#  antecedentes_personales :string(255)
#  antecedentes_familiares :string(255)
#  registrado_por          :string(255)
#

require 'test_helper'

class PacienteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

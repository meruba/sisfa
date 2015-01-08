# == Schema Information
#
# Table name: clientes
#
#  id                       :integer          not null, primary key
#  nombre                   :string(255)
#  direccion                :string(255)
#  numero_de_identificacion :string(255)
#  telefono                 :string(255)
#  email                    :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  sexo                     :string(255)
#  edad                     :integer
#  estado_civil             :string(255)
#  fecha_de_nacimiento      :date
#

require 'test_helper'

class ClienteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

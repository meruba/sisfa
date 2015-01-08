# == Schema Information
#
# Table name: proveedors
#
#  id                       :integer          not null, primary key
#  nombre_o_razon_social    :string(255)      not null
#  codigo                   :string(255)      not null
#  direccion                :string(255)
#  telefono                 :string(255)
#  ciudad                   :string(255)
#  numero_de_identificacion :string(255)      not null
#  pais                     :string(255)
#  representante_legal      :string(255)
#  fax                      :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#

require 'test_helper'

class ProveedorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: pacientes
#
#  id           :integer          not null, primary key
#  tipo         :string(255)
#  grado        :string(255)
#  estado       :string(255)
#  codigo_issfa :string(255)
#  pertenece_a  :string(255)
#  unidad       :string(255)
#  parentesco   :string(255)
#  cliente_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Paciente < ActiveRecord::Base
	belongs_to :cliente
	has_one :historia_clinica
	has_one :informacion_adicional_paciente
	accepts_nested_attributes_for :cliente, :informacion_adicional_paciente
end

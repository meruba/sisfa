class Paciente < ActiveRecord::Base
	belongs_to :cliente
	has_one :historia_clinica
	has_one :informacion_adicional_paciente
	accepts_nested_attributes_for :cliente, :informacion_adicional_paciente
end

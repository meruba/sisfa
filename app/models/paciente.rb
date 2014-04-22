class Paciente < ActiveRecord::Base
	belongs_to :cliente
	has_one :informacion_adicional_paciente

	accepts_nested_attributes_for :cliente
	accepts_nested_attributes_for :informacion_adicional_paciente
end

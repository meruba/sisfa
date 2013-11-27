class Paciente < ActiveRecord::Base
has_one :paciente
#validations
	validates :n_hclinica, :fecha_de_nacimiento, :hora_de_ingreso, :pertenece, :fecha_de_ingreso, :sexo, :estado_civil, :tipo_de_paciente, :presence => true
end

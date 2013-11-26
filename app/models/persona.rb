class Persona < ActiveRecord::Base
	
	belongs_to :persona
#validates
	validates :nombre, :numero_identificacion, :tipo_de_paciente, :presence => true
	validates :nombre, :direccion, :length => { :maximum => 100 }
	validates :numero_identificacion, :uniqueness => true
	validates :telefono, :celular, :numericality => true
end
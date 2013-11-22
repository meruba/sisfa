class Persona < ActiveRecord::Base

#validations
	validates :nombre, :numero_identificacion, :tipo_de_paciente, :presence => true
	validates :nombre, :direcion, :length => { :maximum => 100 }
	validates :numero_identificacion, :uniqueness => true
	validates :telefono, :celular, :numericality => true
	validates :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i 
#relations
	has_many :facturas
	

end
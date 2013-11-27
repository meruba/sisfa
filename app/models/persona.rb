class Persona < ActiveRecord::Base
	
#validates
	validates :nombre, :numero_identificacion, :tipo_de_paciente, :presence => true
	validates :nombre, :direccion, :length => { :maximum => 100 }
	validates :numero_identificacion, :uniqueness => true
	validates :telefono, :celular, :numericality => true
	#validates :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i 
#relations
	belongs_to :persona
	has_many :facturas

end

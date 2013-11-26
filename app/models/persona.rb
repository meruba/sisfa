class Persona < ActiveRecord::Base
	
	belongs_to :persona
#validates
	validates :nombre, :numero_identificacion, :tipo_de_paciente, :presence => true
	validates :nombre, :direccion, :length => { :maximum => 100 }
	validates :numero_identificacion, :uniqueness => true
	validates :telefono, :celular, :numericality => true
<<<<<<< HEAD
=======
	validates :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i 
#relations
	has_many :facturas
	

>>>>>>> 33c689f6c08318727b54f721335cfb91d486282b
end
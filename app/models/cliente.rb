class Cliente < ActiveRecord::Base

#validations
	validates :nombre, :numero_de_identificacion,:presence => true
	validates :nombre, :direccion, :length => { :maximum => 200 }
	validates :numero_de_identificacion, :uniqueness => true
# relationships
	has_one :user
	has_many :proformas
	has_many :facturas

#method

end

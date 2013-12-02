class Proveedor < ActiveRecord::Base
#validations

	validates :nombre_o_razon_social,:presence => true
	#validates :numero_de_identificacion, :presence =>true
	validates :nombre_o_razon_social, :direccion, :pais, :ciudad, :representante_legal, :length => { :maximum => 100 }
	validates :codigo, :presence =>true
#relations
	has_many :facturas

end

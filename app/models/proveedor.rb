# == Schema Information
#
# Table name: proveedors
#
#  id                       :integer          not null, primary key
#  nombre_o_razon_social    :string(255)      not null
#  codigo                   :string(255)      not null
#  direccion                :string(255)
#  telefono                 :string(255)
#  ciudad                   :string(255)
#  numero_de_identificacion :string(255)      not null
#  pais                     :string(255)
#  representante_legal      :string(255)
#  fax                      :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#

class Proveedor < ActiveRecord::Base
#validations

	validates :nombre_o_razon_social,:presence => true
	validates :numero_de_identificacion, :uniqueness => true
  validates_id :numero_de_identificacion
	validates :nombre_o_razon_social, :direccion, :pais, :ciudad, :representante_legal, :length => { :maximum => 100 }
	validates :codigo, :presence =>true
#relations
	has_many :facturas
end

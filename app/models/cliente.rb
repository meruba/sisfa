# == Schema Information
#
# Table name: clientes
#
#  id                       :integer          not null, primary key
#  nombre                   :string(255)
#  direccion                :string(255)
#  numero_de_identificacion :string(255)
#  telefono                 :string(255)
#  email                    :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#

class Cliente < ActiveRecord::Base

#validations
	validates :nombre, :numero_de_identificacion, :presence =>true
	validates :numero_de_identificacion, :uniqueness => true
	validates_id :numero_de_identificacion
# relationships
	has_one :user
	has_one :paciente
	has_many :proformas
	has_many :facturas

#method

end

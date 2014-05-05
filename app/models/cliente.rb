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
#  sexo                     :string(255)
#  edad                     :integer
#  estado_civil             :string(255)
#  fecha_de_nacimiento      :date
#

class Cliente < ActiveRecord::Base

#validations
	validates :nombre, :numero_de_identificacion, :presence =>true
	validates :numero_de_identificacion, :uniqueness => true
	validates_id :numero_de_identificacion, :message => "Cédula incorrecta"
# relationships
  has_one :user
	has_one :paciente
	has_many :proformas
	has_many :facturas
	has_many :registros
	has_many :hospitalizacions
  has_one :cliente_militar
  has_one :militar, through: :cliente_militar

#methods
	
	def self.autocomplete(params)
		clientes = Cliente.includes(:paciente).where("numero_de_identificacion like ?", "%#{params}%").references(:paciente)
    clientes = clientes.map do |cliente|
      {
        :id => cliente.id,
        :label => cliente.numero_de_identificacion + " / " + cliente.nombre,
        :value => cliente.numero_de_identificacion,
        :nombre => cliente.nombre,
        :direccion => cliente.direccion,
        :telefono => cliente.telefono
      }
    end
    clientes 
	end

end

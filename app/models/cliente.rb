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
	validates :nombre, :presence =>true
	validate :validate_id_if_necessary

# relationships
  has_one :user
  has_one :paciente
	has_one :doctor
	has_many :proformas
	has_many :facturas
	has_many :hospitalizacions

#methods
  
  def validate_id_if_necessary
    unless consumidor_final
      errors.add(:numero_de_identificacion, "No es una cédula válida") unless validate_id or self.numero_de_identificacion.blank?
    end
  end

  def consumidor_final
    self.numero_de_identificacion == "9999999999"
  end

  def validate_id
    id_to_eval = IdEcuador.new self.numero_de_identificacion
    id_to_eval.valid?
  end

	def self.autocomplete(params)
		clientes = Cliente.where("numero_de_identificacion like ?", "%#{params}%")
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

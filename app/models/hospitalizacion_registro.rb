# == Schema Information
#
# Table name: hospitalizacion_registros
#
#  id                      :integer          not null, primary key
#  fecha_de_ingreso        :datetime         not null
#  fecha_de_salida         :datetime
#  especialidad            :string(255)      not null
#  medico_asignado         :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  diagnostico_ingreso     :string(255)
#  diagnostico_salida      :string(255)
#  discapacidad            :string(255)
#  dias_hospitalizacion    :integer
#  paciente_id             :integer
#  condicion_egreso        :string(255)
#  diagnostico_sec_egreso1 :string(255)
#  diagnostico_sec_egreso2 :string(255)
#  codigo_cie              :string(255)
#  especialidad_egreso     :string(255)
#  doctor_id               :integer
#

class HospitalizacionRegistro < ActiveRecord::Base
	#relations
	belongs_to :paciente

	#callbacks	
  before_update :set_dias
  # before_validation :set_dias, :on => :update

  #validations
  validates :fecha_de_ingreso, :medico_asignado, :presence => true

  validates :fecha_de_salida, :diagnostico_ingreso, :diagnostico_salida, :presence => true, :on => :update

	#methods
	def set_dias
		unless self.fecha_de_salida.nil?
			self.dias_hospitalizacion = (self.fecha_de_salida.to_date - self.fecha_de_ingreso.to_date).to_i		
		end
	end

	def update_from_paciente
		self.dias_hospitalizacion.nil? == false #solo se calcula una vez editado un registro
	end

	#class methods
	def self.reporte(fecha)
		registros = HospitalizacionRegistro.includes(:paciente).where(fecha_de_salida: fecha).references(:paciente)
	end

	# def self.hospitalizacion
	# 	registros = HospitalizacionRegistro.where(:tipo => "Hospitalizacion")
	# end
end


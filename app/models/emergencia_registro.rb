# == Schema Information
#
# Table name: emergencia_registros
#
#  id              :integer          not null, primary key
#  condicion_id    :integer
#  paciente_id     :integer
#  doctor_id       :integer
#  nombre_medico   :string(255)
#  especialidad    :string(255)
#  tipo_usuario    :string(255)
#  atencion        :string(255)
#  causa           :string(255)
#  destino         :string(255)
#  diagnostico     :string(255)
#  condicion_salir :string(255)
#  grupos_etareos  :string(255)
#  registrado      :boolean          default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#

class EmergenciaRegistro < ActiveRecord::Base
	#relations
	belongs_to :paciente
	belongs_to :doctor
	belongs_to :condicion
	accepts_nested_attributes_for :condicion

	#callbacks
	before_update :set_values
	# after_update :registrado

  #validations
  validates :nombre_medico, :presence => true
  validates :atencion, :causa, :diagnostico, :condicion_salir, :presence => true, :on => :update

	#methods
	# def registrado
	# 	self.registrado = true
	# end

	def set_values
		self.condicion.paciente_id = self.paciente_id
		self.condicion.doctor_id = self.doctor_id
		self.condicion.medico_asignado = self.nombre_medico
		self.condicion.save
	end

	def self.pacientes_emergencia
		pacientes = EmergenciaRegistro.includes(:paciente).where(:registrado => false).references(:paciente)
	end

	def self.pacientes_emergencia_alta
		pacientes = EmergenciaRegistro.includes(:paciente).where(:registrado => true).references(:paciente)
	end
end

# == Schema Information
#
# Table name: consulta_externa_preventivas
#
#  id                     :integer          not null, primary key
#  condicion_id           :integer
#  paciente_id            :integer
#  doctor_id              :integer
#  nombre_medico          :string(255)
#  atencion_preventiva    :string(255)
#  prenatal               :string(255)
#  tipo_de_atencion       :string(255)
#  partos                 :boolean
#  post_partos            :boolean
#  planificacion_familiar :string(255)
#  doc                    :string(255)
#  certificado_medico     :boolean
#  trabajadora_sexual     :boolean
#  grupos_de_edad         :string(255)
#  inicio_atencion        :time
#  fin_atencion           :time
#  horas_trabajadas       :time
#  created_at             :datetime
#  updated_at             :datetime
#  turno_id               :integer
#

class ConsultaExternaPreventiva < ActiveRecord::Base
	belongs_to :paciente
	belongs_to :doctor
	belongs_to :condicion
	belongs_to :turno
	accepts_nested_attributes_for :condicion

	validates :turno_id, :uniqueness =>  { :message => "Este turno ya fue registrado" }


	#callbacks
	after_save :set_values

	#methods
	def set_values
		self.condicion.paciente_id = self.paciente_id
		# self.condicion.doctor_id = self.doctor_id
		self.condicion.medico_asignado = self.nombre_medico
		self.turno.update(:atendido => true)
		self.condicion.save
	end
end

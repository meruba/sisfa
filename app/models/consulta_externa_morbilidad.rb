# == Schema Information
#
# Table name: consulta_externa_morbilidads
#
#  id                    :integer          not null, primary key
#  condicion_id          :integer
#  paciente_id           :integer
#  doctor_id             :integer
#  nombre_medico         :string(255)
#  tipo_de_atencion      :string(255)
#  grupos_de_edad        :string(255)
#  diagnostico_sindrome  :string(255)
#  codigo_cie            :string(255)
#  condicion_diagnostico :string(255)
#  ordenes               :string(255)
#  certificado_medico    :boolean
#  inicio_atencion       :time
#  fin_atencion          :time
#  horas_trabajadas      :time
#  created_at            :datetime
#  updated_at            :datetime
#  turno_id              :integer
#

class ConsultaExternaMorbilidad < ActiveRecord::Base
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

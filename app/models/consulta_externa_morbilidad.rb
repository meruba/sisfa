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
	before_create :calculate_values
	after_save :set_values

	#methods
	def calculate_values
		self.grupos_de_edad = edad_paciente(self.paciente.cliente.fecha_de_nacimiento)
	end

	def set_values
		self.condicion.paciente_id = self.paciente_id
		self.condicion.doctor_id = self.doctor_id
		self.condicion.medico_asignado = self.nombre_medico
		self.condicion.tipo_registro = "Consulta Externa Morbilidad"
		self.condicion.save
		self.turno.update(:atendido => true)
	end
	
	def self.today
		consultas = ConsultaExternaMorbilidad.includes(paciente: [:informacion_adicional_paciente,:cliente]).where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day).references(paciente: [:informacion_adicional_paciente,:cliente])
	end

	private
	def edad_paciente(date)
		birthday = date
		y=(Date.today.year) - (birthday.year)
		m=(Date.today.month)-(birthday.month)
		d=(Date.today.day)-(birthday.day)

		now = Time.now.utc.to_date
		age = now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)

		case
		when m==0 && age == 0
			if y==0
				categoria = 'MENOR DE 1 MES'
			end
		when m>0 && age == 0
			if y==0
				categoria = '1-11 MESES'
			end
		when age > 0 && age < 5
			categoria = '1-4 AÑOS'
		when age > 4 && age < 10
			categoria = '5-9 AÑOS'
		when age >9 && age < 15
			categoria = '10-14 AÑOS'
		when age >14  && age < 20
			categoria = '15-19 AÑOS'
		when age > 19 && age < 50
			categoria = '20-49 AÑOS'
		when age > 49 && age < 65
			categoria = '50-64 AÑOS'
		when age > 65
			categoria = '65 AÑOS +'
		end
		categoria
	end
end

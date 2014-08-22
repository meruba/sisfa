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
	before_create :calculate_values
	before_update :set_values
	# before_validation :set_values
	after_update :add_parte_mensual

  #validations
  validates :nombre_medico, :presence => true
  validates :atencion, :causa, :diagnostico, :condicion_salir, :presence => true, :on => :update
	validate :already_ingresado, on: :create

  def already_ingresado
		paciente = EmergenciaRegistro.where(:paciente_id => self.paciente_id, :registrado => false).last
		unless paciente.nil?
			errors.add :paciente_id, "El paciente ya fue registrado"	
		end		
	end

	#methods
	def calculate_values
		self.grupos_etareos = edad_paciente(self.paciente.cliente.fecha_de_nacimiento)
	end

	def set_values
		self.condicion.paciente_id = self.paciente_id
		self.condicion.doctor_id = self.doctor_id
		self.condicion.medico_asignado = self.nombre_medico
		self.condicion.tipo_registro = "Emergencia"
		self.condicion.save
	end

	def self.ingresados
		emergencias = EmergenciaRegistro.includes(paciente: [:cliente]).where(:registrado => false).references(paciente: [:cliente])
	end

	def add_parte_mensual
		EmergenciaParteMensual.add_emergencia(self)
	end

	private
	def edad_paciente(date)
		birthday = date
		now = Time.now.utc.to_date
		age = now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
		case
		when age == 1
			categoria = '1 AÑO'
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

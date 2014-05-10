# == Schema Information
#
# Table name: turnos
#
#  id             :integer          not null, primary key
#  fecha          :datetime
#  hora           :datetime
#  doctor_a_cargo :string(255)
#  atendido       :boolean          default(FALSE)
#  paciente_id    :integer
#  created_at     :datetime
#  updated_at     :datetime
#  doctor_id      :integer
#  numero         :integer          default(0)
#

class Turno < ActiveRecord::Base
	#relations
	belongs_to :paciente
	belongs_to :doctor

	#callbacks
	before_create :set_values
	
	#	validations
	validates :doctor_a_cargo, :presence => true
	validate :doctor_limit_turnos, :paciente_has_one_turno

	#methos
	def doctor_limit_turnos
		doctor = Doctor.find(self.doctor_id)
		ultimo = doctor.turnos.last
		unless ultimo.nil?
			if ultimo.numero >= doctor.cantidad_turno #limita segun el numero de turnos x doctor
				errors.add :numero, "Turnos llenos para:" + self.doctor_a_cargo
			end
		end
	end

	def paciente_has_one_turno
		turnos = Turno.where(:paciente_id => self.paciente_id, :fecha => Time.now.tomorrow.beginning_of_day..Time.now.tomorrow.end_of_day).last
		unless turnos.nil?
			errors.add :paciente_id, "Ya tiene asignado un turno"					
		end		
	end

	def set_values
		self.atendido = false
		self.fecha = Time.now.tomorrow.beginning_of_day #fecha para el proximo dia
		ultimo = Turno.where(:doctor_id => self.doctor_id).last
		unless ultimo.nil?
			self.numero = ultimo.numero + 1
			self.hora = ultimo.hora + (15*60) #aumenta 15 minuto a partir del ultimo turno
		else
			self.numero = 1
			self.hora = Time.now.beginning_of_day + (510*60) #510x60 = 8:30 am

		end
	end

	def self.last_turno
		turno = Turno.where(:fecha => Time.now.tomorrow.beginning_of_day..Time.now.tomorrow.end_of_day).last
	end

	def self.turnos_today
		turnos = Turno.includes(:paciente).where(:fecha => Time.now.beginning_of_day..Time.now.end_of_day).references(:paciente)
	end

	def self.turnos_tomorrow
		turno = Turno.includes(:paciente).where(:fecha => Time.now.tomorrow.beginning_of_day..Time.now.tomorrow.end_of_day).references(:paciente)
	end
	
end

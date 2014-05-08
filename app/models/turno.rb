# == Schema Information
#
# Table name: turnos
#
#  id             :integer          not null, primary key
#  fecha          :datetime
#  hora           :time
#  doctor_a_cargo :string(255)
#  atendido       :boolean          default(FALSE)
#  paciente_id    :integer
#  created_at     :datetime
#  updated_at     :datetime
#  doctor_id      :integer
#  numero         :integer
#

class Turno < ActiveRecord::Base
	#relations
	belongs_to :paciente
	belongs_to :doctor

	#callbacks
	before_save :set_values
	
	#	validations
	validates :hora, :doctor_a_cargo, :presence => true
	validate :doctor_has_16_turnos, :paciente_has_one_turno

	#methos
	def doctor_has_16_turnos
		ultimo = Turno.where(:doctor_id => self.doctor_id).last
		unless ultimo.nil?
			if ultimo.numero >= 16
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
		self.fecha = Time.now.tomorrow.beginning_of_day #fecha para el proximo dia
		ultimo = Turno.where(:doctor_id => self.doctor_id).last
		unless ultimo.nil?
			self.numero = ultimo.numero + 1
		else
			self.numero = 1
		end
	end

	def self.last_turno
		turno = Turno.where(:fecha => Time.now.tomorrow.beginning_of_day..Time.now.tomorrow.end_of_day).last
	end

	def self.turnos_today
		turnos = Turno.includes(:paciente).where(:fecha => Time.now.beginning_of_day..Time.now.end_of_day).references(:paciente)
	end
end

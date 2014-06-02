# == Schema Information
#
# Table name: doctors
#
#  id             :integer          not null, primary key
#  especialidad   :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  cantidad_turno :integer
#  suspendido     :boolean          default(FALSE)
#  cliente_id     :integer
#

class Doctor < ActiveRecord::Base
	#relations
	belongs_to :cliente
	has_many :emergencia_registros
	has_many :jornada_morbilidads
	has_many :jornada_preventivas
	has_many :turnos
	has_many :consulta_externa_morbilidads, :through => :turnos
	has_many :consulta_externa_preventivas, :through => :turnos
	accepts_nested_attributes_for :cliente
	
	#	validations
	validates :especialidad, :cantidad_turno, :presence => true
	validates :cantidad_turno, :numericality => { :greater_than => 0 }
	#methods
	
	def self.autocomplete(params)
		doctores = Doctor.includes(:cliente).where("nombre like ?", "%#{params}%").references(:cliente)
    doctores = doctores.map do |doctor|
      {
        :id => doctor.id,
        :label => doctor.cliente.nombre + " / " + doctor.especialidad,
        :value => doctor.cliente.nombre,
        :nombre => doctor.cliente.nombre,
        :especialidad => doctor.especialidad
      }
    end
    doctores 
	end

	def self.turnos_doctores
		doctores = []
		Doctor.includes(:turnos).where(:suspendido => false).each do |doctor|
			num_turnos = unless doctor.turnos.last_turno.nil? then doctor.turnos.last.numero else 0 end
			doctores << {
				:nombre =>doctor.cliente.nombre, 
				:turnos_emitidos => num_turnos,
				:turnos_disponibles => doctor.cantidad_turno - num_turnos,
				:especialidad => doctor.especialidad,
				:id => doctor.id
				}
		end
		doctores
	end

	def self.doctor_has_turnos_today
		doctores = Doctor.includes(:turnos).where("turnos.fecha = '%#{Time.now.beginning_of_day..Time.now.end_of_day}%'").references(:turnos)
	end

	def self.list_turnos_all_doctor
		doctores = []
		Doctor.includes(:turnos).each do |doctor|
			turno = doctor.turnos.turnos_today
			unless turno.compact.empty?
				doctores << {
					:nombre =>doctor.cliente.nombre, 
					:turnos => turno
				}
			end
		end
		doctores
	end
end

# == Schema Information
#
# Table name: doctors
#
#  id             :integer          not null, primary key
#  nombre         :string(255)
#  especialidad   :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  cantidad_turno :integer          default(16)
#

class Doctor < ActiveRecord::Base
	#relations
	has_many :turnos
	
	#	validations
	validates :nombre, :especialidad, :cantidad_turno, :presence => true

	#methods
	
	def self.autocomplete(params)
		doctores = Doctor.where("nombre like ?", "%#{params}%")
    doctores = doctores.map do |doctor|
      {
        :id => doctor.id,
        :label => doctor.nombre + " / " + doctor.especialidad,
        :value => doctor.nombre,
        :nombre => doctor.nombre,
        :especialidad => doctor.especialidad
      }
    end
    doctores 
	end

	def self.turnos_doctores
		doctores = []
		Doctor.includes(:turnos).each do |doctor|
			num_turnos = unless doctor.turnos.last_turno.nil? then doctor.turnos.last.numero else 0 end
			doctores << {
				:nombre =>doctor.nombre, 
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

end

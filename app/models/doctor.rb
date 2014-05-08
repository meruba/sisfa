# == Schema Information
#
# Table name: doctors
#
#  id           :integer          not null, primary key
#  nombre       :string(255)
#  especialidad :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Doctor < ActiveRecord::Base
	#relations
	has_many :turnos
	
	#	validations
	validates :nombre, :especialidad, :presence => true

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
				:turnos_disponibles => 16 - num_turnos,
				:especialidad => doctor.especialidad,
				:id => doctor.id
				}
		end
		doctores
	end
end

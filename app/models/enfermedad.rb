# == Schema Information
#
# Table name: enfermedads
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  codigo     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Enfermedad < ActiveRecord::Base
	#methods
	def self.autocomplete(params)
		enfermedades = Enfermedad.where("nombre like ?", "%#{params}%")
		enfermedades = enfermedades.map do |enfermedad|
			{
				:id => enfermedad.id,
				:label => enfermedad.nombre + " / " + enfermedad.codigo,
				:value => enfermedad.nombre,
				:codigo => enfermedad.codigo
			}
		end
		enfermedades 
	end
end

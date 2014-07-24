# == Schema Information
#
# Table name: asignacion_camas
#
#  id                          :integer          not null, primary key
#  cama_id                     :integer
#  hospitalizacion_registro_id :integer
#  numero_cama                 :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#

class AsignacionCama < ActiveRecord::Base
	belongs_to :hospitalizacion_registro
	belongs_to :cama

	before_create :set_numero_cama
	after_create :update_cama

	validates :hospitalizacion_registro_id, :uniqueness => true

	def set_numero_cama
		self.numero_cama =  self.cama.numero
	end
	
	def update_cama
		self.cama.update(:ocupada => true)
	end
end

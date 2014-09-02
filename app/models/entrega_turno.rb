# == Schema Information
#
# Table name: entrega_turnos
#
#  id         :integer          not null, primary key
#  servicio   :string(255)
#  fecha      :datetime
#  created_at :datetime
#  updated_at :datetime
#

class EntregaTurno < ActiveRecord::Base
	has_many :item_entrega_turnos
	# validations
	validates :servicio, :presence =>true
	# validates_uniqueness_of :servicio, :case_sensitive => false #servicio es unico sea escrito mayuscula o minuscula

	before_save :to_upcase
	before_destroy :check_items

	def to_upcase
		self.servicio = self.servicio.upcase
		
	end
	private
	def check_items
		unless item_entrega_turnos.empty?
			self.errors[:base] << "No se puede eliminar ya contiene informacion."
			return false
		end
	end
end

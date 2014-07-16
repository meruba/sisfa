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
	validates_uniqueness_of :servicio, :case_sensitive => false #servicio es unico sea escrito mayuscula o minuscula
end

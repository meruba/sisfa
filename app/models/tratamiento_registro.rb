# == Schema Information
#
# Table name: tratamiento_registros
#
#  id                  :integer          not null, primary key
#  nombre_tratamiento  :string(255)
#  asignar_horario_id  :integer
#  item_tratamiento_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class TratamientoRegistro < ActiveRecord::Base
	attr_accessor :tratamiento_recibido

	belongs_to :asignar_horario
	belongs_to :item_tratamiento

	validates :nombre_tratamiento, :presence => true
	after_save :set_values

	def tratamiento_recibido
		if self.item_tratamiento
			self.item_tratamiento.nombre
		end
	end

	def set_values
		self.nombre_tratamiento = self.item_tratamiento.nombre
	end
end

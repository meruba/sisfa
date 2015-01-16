# == Schema Information
#
# Table name: asignar_horarios
#
#  id                  :integer          not null, primary key
#  numero_terapias     :integer
#  fecha_inicio        :datetime
#  fecha_final         :datetime
#  item_tratamiento_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#  paciente_id         :integer
#

class AsignarHorario < ActiveRecord::Base
	belongs_to :paciente
	has_many :resultado_tratamientos
	# validates :numero_terapias, :fecha_inicio, :item_tratamiento_id, :presence => true
	validates :numero_terapias, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 40, :message => "Rango maximo de 0-40 terapias" }
	
	accepts_nested_attributes_for :resultado_tratamientos
	
	after_create :set_values

	def set_values
		self.numero_terapias.times do
			sesion = self.resultado_tratamientos.build
			sesion.save
		end
	end
end

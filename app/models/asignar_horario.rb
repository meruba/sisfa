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
		self.numero_terapias.times do |i|
			day = self.fecha_inicio + i.days
			sesion = self.resultado_tratamientos.build
			sesion.fecha = not_weekend_days(day)
			sesion.save
		end
	end
	
	private

	def not_weekend_days(day)
		case
		when day.wday == 6
			day = day + 2.days
		when day.wday == 0
			day = day + 1.days
		end
		day
		# if day.wday == 6 #es sabado	
		# 	day = day + 2.days
		# else if day.wday == 0 #es domingo
		# 	day = day + 1.days
		# 	raise
		# else
		# 	day = day
		# end
		# end
	end
end

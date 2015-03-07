# == Schema Information
#
# Table name: asignar_horarios
#
#  id              :integer          not null, primary key
#  numero_terapias :integer
#  fecha_inicio    :datetime
#  fecha_final     :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  paciente_id     :integer
#  numero_factura  :integer
#  total_factura   :float            default(0.0)
#  diagnostico     :string(255)
#

class AsignarHorario < ActiveRecord::Base
	belongs_to :paciente
	has_many :resultado_tratamientos, dependent: :destroy
	has_many :tratamiento_registros, dependent: :destroy

	validates :paciente_id, :numero_factura, :total_factura, :diagnostico, :presence => true
	# validates :numero_terapias, :fecha_inicio, :item_tratamiento_id, :presence => true
	# validates :numero_terapias, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 40, :message => "Rango maximo de 0-40 terapias" }

	accepts_nested_attributes_for :resultado_tratamientos, :tratamiento_registros

	# before_create :set_values

	private

	def not_weekend_days(day)
		case
		when day.wday == 6
			day = day + 2.days
		when day.wday == 0
			day = day + 1.days
		end
		day
	end
end

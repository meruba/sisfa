# == Schema Information
#
# Table name: asignar_horarios
#
#  id               :integer          not null, primary key
#  numero_terapias  :integer
#  fecha_inicio     :datetime
#  fecha_final      :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  paciente_id      :integer
#  numero_factura   :integer
#  total_factura    :float            default(0.0)
#  diagnostico      :string(255)
#  doctor_remitente :string(255)
#  alta             :boolean          default(FALSE)
#

class AsignarHorario < ActiveRecord::Base
	belongs_to :paciente
	has_many :resultado_tratamientos, dependent: :destroy
	has_many :tratamiento_registros, dependent: :destroy

	validates :numero_factura, :total_factura, :diagnostico, :presence => true
	validates :paciente_id, :presence => { :message => "Debe elejir al paciente de la lista de resultados" }
	validate :yet_in_tratamiento, on: :create

	# validates :numero_terapias, :fecha_inicio, :item_tratamiento_id, :presence => true
	# validates :numero_terapias, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 40, :message => "Rango maximo de 0-40 terapias" }

	accepts_nested_attributes_for :resultado_tratamientos, :tratamiento_registros

	def yet_in_tratamiento
		is_tratamiento = AsignarHorario.where(:paciente_id => self.paciente, :alta => false).last
		unless is_tratamiento.nil?
      errors.add :paciente_id, "El paciente ya esta recibiendo tratamiento"
		end
	end

	def self.autocomplete(params)
		pacientes = AsignarHorario.includes(paciente: [:cliente]).where("clientes.nombre like ?", "%#{params}%").references(paciente: [:cliente])
		pacientes = pacientes.map do |terapia|
			{
				:paciente_id => terapia.paciente.id,
				:label => terapia.paciente.cliente.nombre + " / " + "H.C:" + terapia.paciente.n_hclinica.to_s,
				:value => terapia.paciente.cliente.nombre
			}
		end
		pacientes
	end

	def self.reporte_mensual(date)
		fecha = date.to_time
		ingresados = self.where(:created_at => fecha.beginning_of_month..fecha.end_of_month)
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
	end
end

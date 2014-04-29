# == Schema Information
#
# Table name: registros
#
#  id                   :integer          not null, primary key
#  fecha_de_ingreso     :datetime         not null
#  fecha_de_salida      :datetime
#  especialidad         :string(255)      not null
#  medico_asignado      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  diagnostico_ingreso  :string(255)
#  diagnostico_salida   :string(255)
#  discapacidad         :string(255)
#  dias_hospitalizacion :integer
#  paciente_id          :integer
#

class Registro < ActiveRecord::Base
	#relations
	belongs_to :paciente

	#callbacks	
  before_update :set_dias

  #validations
  validates :fecha_de_ingreso, :medico_asignado, :presence => true

  validates :fecha_de_salida, :diagnostico_ingreso, :diagnostico_salida, :presence => true, :on => :update

	#methods
	def set_dias
		self.dias_hospitalizacion = (self.fecha_de_salida.to_date - self.fecha_de_ingreso.to_date).to_i
	end

	def self.reporte(fecha)
		registros = Registro.includes(:paciente).where(created_at: fecha).references(:paciente)
	end
end

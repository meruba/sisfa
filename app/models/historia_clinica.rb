class HistoriaClinica < ActiveRecord::Base

#validations
  validates :fecha, :presence => true

#relations
	belongs_to :paciente
	has_many :registros  
	accepts_nested_attributes_for :registros, :paciente

#callbacks
before_validation :set_values

	def set_values
		self.registros.each do |f|
			f.fecha_de_ingreso = Time.now
		end	
	end
end

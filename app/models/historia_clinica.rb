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
		if self.paciente.tipo == "familiar"
			self.paciente.estado = ""
			self.paciente.grado = ""
			self.paciente.pertenece_a = ""
			self.paciente.unidad = ""
		else if self.paciente.tipo == "civil"
			self.paciente.estado = ""
			self.paciente.grado = ""
			self.paciente.pertenece_a = ""
			self.paciente.unidad = ""
			self.paciente.parentesco = ""
			self.paciente.codigo_issfa = ""
		end
	end
	end
end

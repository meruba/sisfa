# == Schema Information
#
# Table name: pacientes
#
#  id             :integer          not null, primary key
#  tipo           :string(255)
#  grado          :string(255)
#  estado         :string(255)
#  codigo_issfa   :string(255)
#  pertenece_a    :string(255)
#  unidad         :string(255)
#  parentesco     :string(255)
#  cliente_id     :integer
#  created_at     :datetime
#  updated_at     :datetime
#  n_hclinica     :integer
#  fecha_hclinica :date
#

class Paciente < ActiveRecord::Base
	belongs_to :cliente
	has_many :registros
	has_one :informacion_adicional_paciente
	accepts_nested_attributes_for :cliente, :informacion_adicional_paciente, :registros
	
	#callbacks
	before_validation :set_values

	#validation
	validates :tipo, :presence => true
  validates :cliente_id, :uniqueness =>  { :message => "Esta persona ya tiene una historia clinica" }

#methods
	def cliente_attributes=(attributes)
		if attributes['id'].present?
	    self.cliente = Cliente.find(attributes['id'])
	  end
	  super
	end

	def set_values
		self.fecha_hclinica = Time.now
		self.registros.each do |f|
			f.fecha_de_ingreso = Time.now
		end
		if self.tipo == "familiar"
			self.estado = ""
			self.grado = ""
			self.pertenece_a = ""
			self.unidad = ""
		else if self.tipo == "civil"
			self.estado = ""
			self.grado = ""
			self.pertenece_a = ""
			self.unidad = ""
			self.parentesco = ""
			self.codigo_issfa = ""
		end
	end
	end
end

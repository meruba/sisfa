# == Schema Information
#
# Table name: camas
#
#  id         :integer          not null, primary key
#  cuarto_id  :integer
#  numero     :integer
#  ocupada    :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Cama < ActiveRecord::Base
	belongs_to :cuarto
	has_one :asignacion_cama
	validates :numero, :presence =>true
	validates :numero, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 99, :message => "Rango maximo de 0-99" }
	validate :numero_is_unique_cuarto, :on => :create
	
	#callbacks
	before_destroy :check_cuartos
	
	#methods
	def numero_is_unique_cuarto
		self.cuarto.camas.each do |cama|
			if cama.numero == self.numero
				errors.add :numero, "Ya existe este cama"
			end
		end
	end

	private
	def check_cuartos
		if self.ocupada?     
			self.errors[:base] << "No se puede eliminar cama ocupada."
			return false   
		end
	end
end

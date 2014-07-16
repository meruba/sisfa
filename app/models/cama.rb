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
	validate :numero_is_unique_cuarto, :on => :create

	def numero_is_unique_cuarto
		self.cuarto.camas.each do |cama|
			if cama.numero == self.numero
				errors.add :numero, "Ya existe este cama"
			end
		end
	end
end

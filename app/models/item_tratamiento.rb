# == Schema Information
#
# Table name: item_tratamientos
#
#  id             :integer          not null, primary key
#  codigo         :string(255)
#  nombre         :string(255)
#  tratamiento_id :integer
#  created_at     :datetime
#  updated_at     :datetime

class ItemTratamiento < ActiveRecord::Base
	belongs_to :tratamiento
	has_many :tratamiento_registros, dependent: :destroy

	validates :nombre, :codigo, :presence => true

#class methods
	def self.autocomplete(params)
		tratamientos = ItemTratamiento.includes(:tratamiento).where("codigo like ?", "%#{params}%").references(:tratamientos)
		tratamientos = tratamientos.map do |t|
			{
				:id => t.id,
				:label => t.nombre + " / " + "Seccion:" + t.tratamiento.nombre.to_s,
				:value => t.nombre
			}
		end
		tratamientos
	end
end

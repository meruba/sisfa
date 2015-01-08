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
	validates :nombre, :codigo, :presence => true

end

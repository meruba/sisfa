# == Schema Information
#
# Table name: tratamientos
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  numeracion :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tratamiento < ActiveRecord::Base
	has_many :item_tratamientos #relacion
	accepts_nested_attributes_for :item_tratamientos
	validates :nombre, :presence => true 
end
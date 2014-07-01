# == Schema Information
#
# Table name: item_nota_enfermeras
#
#  id                :integer          not null, primary key
#  nota_enfermera_id :integer
#  user_id           :integer
#  fecha             :datetime
#  hora              :datetime
#  nota              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class ItemNotaEnfermera < ActiveRecord::Base
	#relation
  belongs_to :nota_enfermera
	belongs_to :user
	
	#validation
	validates :fecha, :hora, :nota, :presence => true
end

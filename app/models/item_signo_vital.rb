# == Schema Information
#
# Table name: item_signo_vitals
#
#  id               :integer          not null, primary key
#  signo_vital_id   :integer
#  user_id          :integer
#  fecha            :datetime
#  hora             :datetime
#  temperatura      :string(255)
#  pulso            :string(255)
#  respiracion      :string(255)
#  tension_arterial :string(255)
#  observacion      :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class ItemSignoVital < ActiveRecord::Base
	#relation
  belongs_to :signo_vital
	belongs_to :user
	
	#validation
	validates :fecha, :hora, :temperatura, :pulso, :respiracion, :tension_arterial, :observacion, :presence => true
end

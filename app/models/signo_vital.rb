# == Schema Information
#
# Table name: signo_vitals
#
#  id                          :integer          not null, primary key
#  hospitalizacion_registro_id :integer
#  created_at                  :datetime
#  updated_at                  :datetime
#

class SignoVital < ActiveRecord::Base
	#relations
	belongs_to :hospitalizacion_registro
	has_many :item_signo_vitals, :order => 'created_at DESC'
end

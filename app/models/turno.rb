# == Schema Information
#
# Table name: turnos
#
#  id          :integer          not null, primary key
#  fecha       :datetime
#  hora        :time
#  doctor      :string(255)
#  atendido    :boolean          default(FALSE)
#  paciente_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Turno < ActiveRecord::Base
	#relations
	belongs_to :paciente
	
	#	validations
	validates :fecha, :hora, :doctor, :presence => true
end

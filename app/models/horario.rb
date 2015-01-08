# == Schema Information
#
# Table name: horarios
#
#  id          :integer          not null, primary key
#  hora        :string(255)
#  paciente_id :integer
#  created_at  :datetime
#  updated_at  :datetime
class Horario < ActiveRecord::Base
	validates :hora, :paciente_id, :presences => true	
end
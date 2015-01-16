# == Schema Information
#
# Table name: resultado_tratamientos
#
#  id          :integer          not null, primary key
#  personal_id :integer
#  resultado   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
class ResultadoTratamiento < ActiveRecord::Base
	belongs_to :asignar_horario
	validates :resultado, :personal_id, :presence => true, :on => :update
end
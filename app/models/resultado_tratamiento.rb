# == Schema Information
#
# Table name: resultado_tratamientos
#
#  id                 :integer          not null, primary key
#  personal_id        :integer
#  resultado          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  atendido           :boolean          default(FALSE)
#  razon_editado      :string(255)
#  asignar_horario_id :integer
#

class ResultadoTratamiento < ActiveRecord::Base
	belongs_to :asignar_horario
	validates :resultado, :personal_id, :presence => true, :on => :update
end

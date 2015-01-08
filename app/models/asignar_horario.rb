# == Schema Information
#
# Table name: asignar_horarios
#
#  id                  :integer          not null, primary key
#  numero_terapias     :integer
#  fecha_inicio        :datetime
#  fecha_final         :datetime
#  item_tratamiento_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class AsignarHorario < ActiveRecord::Base
	validates :numero_terapias, :fecha_inicio, :item_tratamiento_id, :presences => true
	validates :numero_terapias, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 40, :message => "Rango maximo de 0-40 terapias" }
end

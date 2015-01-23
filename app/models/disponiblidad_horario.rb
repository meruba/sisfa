# == Schema Information
#
# Table name: disponiblidad_horarios
#
#  id                       :integer          not null, primary key
#  lleno                    :boolean          default(FALSE)
#  resultado_tratamiento_id :integer
#  dia                      :datetime
#  created_at               :datetime
#  updated_at               :datetime
#

class DisponiblidadHorario < ActiveRecord::Base
		#relations
		belongs_to :resultado_tratamiento
end

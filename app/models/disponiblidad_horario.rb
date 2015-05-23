# == Schema Information
#
# Table name: disponiblidad_horarios
#
#  id                   :integer          not null, primary key
#  lleno                :boolean          default(FALSE)
#  dia                  :datetime
#  created_at           :datetime
#  updated_at           :datetime
#  numero_actual_turnos :integer
#  numero_horarios      :integer
#  turnos_por_dia       :integer
#  config_turnos        :integer
#

class DisponiblidadHorario < ActiveRecord::Base
end

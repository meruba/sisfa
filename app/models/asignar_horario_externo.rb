# == Schema Information
#
# Table name: asignar_horario_externos
#
#  id                  :integer          not null, primary key
#  paciente_id         :integer
#  item_tratamiento_id :integer
#  diagnostico         :string(255)
#  asignar_horario_id  :integer
#  created_at          :datetime
#  updated_at          :datetime
class AsignarHorarioExterno < ActiveRecord::Base
	validates :item_tratamiento_id, :diagnostico, :asignar_horario_id :presences => true
	validates :numero_terapias, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 40, :message => "Rango maximo de 0-40 terapias" } #verifica que sea un nnumero y da un rango de maximo 
end

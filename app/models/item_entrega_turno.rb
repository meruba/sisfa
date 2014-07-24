# == Schema Information
#
# Table name: item_entrega_turnos
#
#  id                          :integer          not null, primary key
#  entrega_turno_id            :integer
#  hospitalizacion_registro_id :integer
#  user_id                     :integer
#  tipo_item                   :string(255)
#  descripcion                 :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#

class ItemEntregaTurno < ActiveRecord::Base
	belongs_to :entrega_turno
	belongs_to :hospitalizacion_registro
	belongs_to :user

	# validations
	validates :descripcion, :hospitalizacion_registro_id, :presence =>true
	
end

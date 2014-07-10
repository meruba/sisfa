# == Schema Information
#
# Table name: camas
#
#  id         :integer          not null, primary key
#  cuarto_id  :integer
#  numero     :integer
#  ocupada    :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Cama < ActiveRecord::Base
	belongs_to :cuarto
	has_one :asignacion_cama
end

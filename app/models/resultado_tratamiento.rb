# == Schema Information
#
# Table name: resultado_tratamientos
#
#  id          :integer          not null, primary key
#  personal_id :integer
#  resultado   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class ResultadoTratamiento < ActiveRecord::Base
end

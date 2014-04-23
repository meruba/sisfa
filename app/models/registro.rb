# == Schema Information
#
# Table name: registros
#
#  id                   :integer          not null, primary key
#  fecha_de_ingreso     :datetime         not null
#  fecha_de_salida      :datetime
#  especialidad         :string(255)      not null
#  medico_asignado      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  historia_clinica_id  :integer
#  diagnostico_ingreso  :string(255)
#  diagnostico_salida   :string(255)
#  discapacidad         :string(255)
#  dias_hospitalizacion :integer
#

class Registro < ActiveRecord::Base
	#relations
	belongs_to :historia_clinica

end

# == Schema Information
#
# Table name: registros
#
#  id               :integer          not null, primary key
#  n_hclinica       :integer          not null
#  fecha_de_ingreso :datetime         not null
#  fecha_de_salida  :datetime
#  especialidad     :string(255)      not null
#  medico_asignado  :string(255)
#  cliente_id       :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Registro < ActiveRecord::Base
	belongs_to :cliente
	accepts_nested_attributes_for :cliente
end

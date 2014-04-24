# == Schema Information
#
# Table name: informacion_adicional_pacientes
#
#  id                 :integer          not null, primary key
#  ciudad             :string(255)
#  provincia          :string(255)
#  canton             :string(255)
#  jefe_de_reparto    :string(255)
#  familiar_cercano   :string(255)
#  familiar_direccion :string(255)
#  familiar_telefono  :string(255)
#  observacion        :string(255)
#  paciente_id        :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class InformacionAdicionalPaciente < ActiveRecord::Base
	belongs_to :paciente
end

# == Schema Information
#
# Table name: informacion_adicional_pacientes
#
#  id                  :integer          not null, primary key
#  parroquia           :string(255)
#  provincia           :string(255)
#  canton              :string(255)
#  familiar_cercano    :string(255)
#  familiar_direccion  :string(255)
#  familiar_telefono   :string(255)
#  observacion         :string(255)
#  paciente_id         :integer
#  created_at          :datetime
#  updated_at          :datetime
#  nacionalidad        :string(255)
#  raza                :string(255)
#  familiar_parentesco :string(255)
#  representante_legal :string(255)      default("")
#

class InformacionAdicionalPaciente < ActiveRecord::Base
	belongs_to :paciente
end

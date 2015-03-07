# == Schema Information
#
# Table name: condicions
#
#  id                       :integer          not null, primary key
#  paciente_id              :integer
#  doctor_id                :integer
#  medico_asignado          :string(255)
#  motivo_de_consulta       :string(255)
#  enfermedad_actual        :text
#  revision_organos_sistema :string(255)
#  presion_arterial         :string(255)
#  pulso                    :string(255)
#  temperatura              :string(255)
#  examen_fisico            :string(255)
#  diagnostico_1            :string(255)
#  diagnostico_2            :string(255)
#  planes                   :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  tipo_registro            :string(255)
#  codigo_cie_1             :string(255)
#  codigo_cie_2             :string(255)
#

class Condicion < ActiveRecord::Base
	#relations
	has_one :emergencia_registro
	has_one :consulta_externa_morbilidad
	has_one :consulta_externa_preventiva
	belongs_to :paciente
	belongs_to :doctor
  validates :motivo_de_consulta, :enfermedad_actual, :pulso, :presion_arterial, :temperatura, :presence => true
end

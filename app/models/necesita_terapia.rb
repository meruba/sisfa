# == Schema Information
#
# Table name: necesita_terapia
#
#  id                             :integer          not null, primary key
#  paciente_id                    :integer
#  consulta_externa_morbilidad_id :integer
#  enviar_fisiatria               :boolean          default(FALSE)
#  created_at                     :datetime
#  updated_at                     :datetime
#

class NecesitaTerapia < ActiveRecord::Base
  belongs_to :paciente
  belongs_to :consulta_externa_morbilidad
end

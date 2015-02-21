# == Schema Information
#
# Table name: horarios
#
#  id          :integer          not null, primary key
#  hora        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  hora_inicio :string(255)
#  hora_final  :string(255)
#  anulado     :boolean          default(FALSE)
#

class Horario < ActiveRecord::Base
	# belongs_to :paciente
	belongs_to :asignar_horario
	validates :hora_inicio, :hora_final, :presence =>true
	validates_uniqueness_of :hora, :case_sensitive => false #nombre es unico sea escrito mayuscula o minuscula

  before_save :set_values

  def set_values
    self.hora = self.hora_inicio + " - " + self.hora_final
  end
end

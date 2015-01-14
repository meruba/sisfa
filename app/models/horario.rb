# == Schema Information
#
# Table name: horarios
#
#  id          :integer          not null, primary key
#  hora        :string(255)
#  paciente_id :integer
#  created_at  :datetime
#  updated_at  :datetime
class Horario < ActiveRecord::Base
	belongs_to :paciente
	validates :hora, :presence =>true
	validates_uniqueness_of :hora, :case_sensitive => false #nombre es unico sea escrito mayuscula o minuscula
end
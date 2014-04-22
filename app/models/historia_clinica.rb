class HistoriaClinica < ActiveRecord::Base

#validations
  validates :fecha, :presence => true

#relations
	belongs_to :paciente
	has_many :registros  
	accepts_nested_attributes_for :registros, :paciente
end

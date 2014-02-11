class Registro < ActiveRecord::Base
	belongs_to :cliente
	accepts_nested_attributes_for :cliente
end

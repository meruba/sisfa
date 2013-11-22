class Kardex < ActiveRecord::Base
#validations
	validates :fecha, :presences => true
#relations
has_many :lineaKardexes
has_many :productos, :thorugh => :lineaKardexes
end

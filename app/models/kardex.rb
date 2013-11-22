class Kardex < ActiveRecord::Base
#validations
	validates :fecha, :presences => true
end

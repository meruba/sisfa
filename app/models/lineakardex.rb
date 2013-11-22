class Lineakardex < ActiveRecord::Base
#validations
	validates :tipo, :fecha, :cantidad, :v_unitario, :presences => true
	validates :cantidad, :v_unitario :numericality => true, :numericality => { :greater_than_or_equal_to =>0 }
#relations
	belongs_to :producto
	belongs_to :kardex

end

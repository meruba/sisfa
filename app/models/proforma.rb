class Proforma < ActiveRecord::Base
#validations
	validates :fecha_emision, :numero, :iva, :subtotal_0, :subtotal_12, :descuento, :total, :presences =>true
	validates :numero, :iva, :subtotal_0, :subtotal_12, :descuento, :total, :numericality => true, :numericality => { :greater_than_or_equal_to =>0 }
end

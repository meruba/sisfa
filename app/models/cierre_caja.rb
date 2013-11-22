class CierreCaja < ActiveRecord::Base
#validations
	validates :fecha, :total_ingreso_externo, :total_ingreso_hospitalizacion, :numero_total_facturas, :presences =>true
	validates :total_ingreso_externo, :total_ingreso_hospitalizacion, :numero_total_facturas, :numericality =>true, :numericality => { :greater_than_or_equal_to =>0 }
	

end

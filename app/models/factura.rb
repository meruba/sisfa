class Factura < ActiveRecord::Base
#relations
belongs_to :persona
has_many :item_facturas
has_many :productos, :thorugh => :item_facturas
#valitations
validates :numero, :fecha_de_emision, :fecha_de_vencimiento, :subtotal_0, :subtotal_12, :descuento, :iva, :total, :presence =>true
validates :numero, :subtotal_0, :subtotal_12, :descuento, :iva, :total, :numericality => true, :numericality => { :greater_than_or_equal_to => 0 }

	
end

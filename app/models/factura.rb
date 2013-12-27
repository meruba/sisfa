class Factura < ActiveRecord::Base
#relations
belongs_to :cliente
belongs_to :proveedor
has_many :item_facturas
has_many :productos, :through => :item_facturas

#nested
# accepts_nested_attributes_for :cliente
accepts_nested_attributes_for :item_facturas

#valitations
validates :numero, :fecha_de_emision, :fecha_de_vencimiento, :subtotal_0, :subtotal_12, :descuento, :iva, :total, :presence =>true
validates :numero, :subtotal_0, :subtotal_12, :descuento, :iva, :total, :numericality => true, :numericality => { :greater_than_or_equal_to => 0 }

#methods
item_facturas = []
def self.disminuir_stock (item_facturas)
	item_facturas.each do |item|
		unless item.producto_id.nil?
			producto  = Producto.find(item.producto_id)
			producto.cantidad_disponible -= item.cantidad
			producto.save
		end
	end
	# item_facturas.each do |value, key|
	# 	producto  = Producto.find("#{key[:producto_id]}")
	# 	cantidad_item = item_facturas[value][:cantidad].to_f
	# 	producto.cantidad_disponible -= cantidad_item
	# 	raise 'error'
	# 	producto.save
	# end
end

end

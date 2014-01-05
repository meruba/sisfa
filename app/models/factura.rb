# == Schema Information
#
# Table name: facturas
#
#  id                   :integer          not null, primary key
#  numero               :integer          not null
#  observacion          :string(255)
#  fecha_de_emision     :datetime         not null
#  fecha_de_vencimiento :datetime         not null
#  subtotal_0           :float            not null
#  subtotal_12          :float            not null
#  descuento            :float            not null
#  iva                  :float            not null
#  total                :float            not null
#  created_at           :datetime
#  updated_at           :datetime
#  cliente_id           :integer          not null
#  tipo                 :string(255)      not null
#  anulada              :boolean          default(FALSE)
#

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

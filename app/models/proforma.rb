# == Schema Information
#
# Table name: proformas
#
#  id            :integer          not null, primary key
#  fecha_emision :date             not null
#  numero        :integer          not null
#  iva           :float            not null
#  subtotal_0    :float            not null
#  subtotal_12   :float            not null
#  descuento     :float            not null
#  total         :float            not null
#  created_at    :datetime
#  updated_at    :datetime
#  cliente_id    :integer          not null
#  facturado     :boolean          default(FALSE)
#

class Proforma < ActiveRecord::Base
#relations
belongs_to :cliente
has_many :item_proformas
has_many :ingreso_productos, :through => :item_proformas

#nested
accepts_nested_attributes_for :item_proformas, :cliente

#valitations
validates :numero, :subtotal_0, :subtotal_12, :iva, :total, :presence =>true
validates :numero, :subtotal_0, :subtotal_12, :iva, :numericality => true, :numericality => { :greater_than_or_equal_to => 0 }
validates :total, :numericality => { :greater_than => 0 }

#callbacks
before_validation :set_proforma_values

#methods
def cliente_attributes=(attributes)
	if attributes['id'].present?
		self.cliente = Cliente.find(attributes['id'])
	end
	super
end

def set_proforma_values
	self.fecha_emision = Time.now
  self.numero = Proforma.last ? Proforma.last.numero + 1 : 1
	subtotal = 0
	subtotal_0 = 0
	subtotal_12 = 0
	iva = 0
	self.item_proformas.each do |item|
		unless item.ingreso_producto_id.nil?
			ingreso = IngresoProducto.find item.ingreso_producto_id
			cantidad = item.cantidad
			item.valor_unitario = ingreso.producto.precio_venta #asigna el valor del item
			item.total = (ingreso.producto.precio_venta * cantidad).round(2) #asigna valor total del item
			# subtotal = subtotal + item.total
			if ingreso.producto.hasiva == true
				subtotal_12 = subtotal_12 + item.total
				item.iva = (cantidad * (ingreso.producto.precio_venta * 0.12).round(2))
			else
				subtotal_0 = subtotal_0 + item.total
				item.iva = 0
			end
			iva = iva + item.iva #suma iva de los productos
		end
	end
	self.iva = iva.round(2)
	self.subtotal_0 = subtotal_0
	self.subtotal_12 = subtotal_12
	self.total = subtotal_0 + subtotal_12 + self.iva
	self.total = self.total.round(2)
	self.descuento = 0
end
end

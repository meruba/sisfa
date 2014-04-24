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
#  tipo                 :string(255)      not null
#  anulada              :boolean          default(FALSE)
#  proveedor_id         :integer
#  cliente_id           :integer
#  user_id              :integer
#  razon_anulada        :string(255)
#

class Factura < ActiveRecord::Base
#relations
belongs_to :cliente
belongs_to :proveedor
belongs_to :user
has_many :item_facturas
has_many :ingreso_productos, :through => :item_facturas

#nested
# accepts_nested_attributes_for :cliente
accepts_nested_attributes_for :item_facturas, :cliente

#valitations
validates :numero, :subtotal_0, :subtotal_12, :descuento, :iva, :total, :presence =>true
validates :numero, :subtotal_0, :subtotal_12, :descuento, :iva, :numericality => true, :numericality => { :greater_than_or_equal_to => 0 }
validates :total, :numericality => { :greater_than => 0 }

#callbacks
before_validation :set_factura_values

after_save :add_liquidacion

#methods

def cliente_attributes=(attributes)
	if attributes['id'].present?
    self.cliente = Cliente.find(attributes['id'])
  end
  super
end

def set_factura_values
	self.fecha_de_emision = Time.now
  self.fecha_de_vencimiento = Time.now + 30.days
  self.numero = Factura.last ? Factura.last.numero + 1 : Emisor.numero_inicial
	subtotal_0 = 0
	subtotal_12 = 0
	iva = 0
	self.item_facturas.each do |item|
		unless item.ingreso_producto_id.nil?
			ingreso = IngresoProducto.find item.ingreso_producto_id
			cantidad = item.cantidad
			item.tipo = "venta"
			item.valor_unitario = ingreso.producto.precio_venta #asigna el valor del item
			item.total = (ingreso.producto.precio_venta * cantidad).round(2) #asigna valor total del item
			if ingreso.producto.hasiva == true
				subtotal_12 = subtotal_12 + item.total
				item.iva = (ingreso.producto.precio_venta * 0.12).round(2)
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

def self.create_items_facturas (item_proformas)
	itemfacturas = []
	item_proformas.each do |item|
		itemfactura = ItemFactura.new(:cantidad => item.cantidad, :ingreso_producto => item.ingreso_producto, :valor_unitario => item.valor_unitario, :descuento => item.descuento, :total => item.total, :iva => item.iva)
		itemfacturas << itemfactura
	end
	itemfacturas
end

def rollback_factura
	self.item_facturas.each do |item|
		ingreso_producto = item.ingreso_producto
		ingreso_producto.cantidad = ingreso_producto.cantidad + item.cantidad
		ingreso_producto.producto.stock = ingreso_producto.producto.stock + item.cantidad #suma al stock si se anula
		Lineakardex.create(:kardex => ingreso_producto.producto.kardex, :tipo => "Entrada", :fecha => Time.now, :cantidad => item.cantidad, :v_unitario => item.ingreso_producto.producto.precio_venta, :observaciones => "Factura anulada" )
		ingreso_producto.save
		ingreso_producto.producto.save
	end
end

def anular_factura(razon)
	self.anulada = true
	self.razon_anulada = razon
	self.rollback_factura
	self.save
end

def add_liquidacion
	total = 0
	self.item_facturas.each do |item|
		ingreso = IngresoProducto.find item.ingreso_producto_id
		total = total + (ingreso.producto.precio_compra * item.cantidad).round(2)
		#obtine el total de la venta sin ganacia
	end
	Liquidacion.add_factura(self, total)
end

end

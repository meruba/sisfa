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
accepts_nested_attributes_for :item_facturas
#valitations
validates :numero, :fecha_de_emision, :fecha_de_vencimiento, :subtotal_0, :subtotal_12, :descuento, :iva, :total, :presence =>true
validates :numero, :subtotal_0, :subtotal_12, :descuento, :iva, :numericality => true, :numericality => { :greater_than_or_equal_to => 0 }
validates :total, :numericality => { :greater_than => 0 }

#methods

def self.item_compra (item_facturas)
	item_facturas.each do |item|		
		item.tipo = "compra"
	end
end

def set_to_item_venta
	self.item_facturas.each do |item|		
		item.tipo = "venta"
	end
end

def self.create_items_facturas (item_proformas)
	itemfacturas = []
	item_proformas.each do |item|
		itemfactura = ItemFactura.new(:cantidad => item.cantidad, :ingreso_producto => item.ingreso_producto, :valor_unitario => item.valor_unitario, :descuento => item.descuento, :total => item.total, :iva => item.iva)
		itemfacturas << itemfactura
	end
	itemfacturas
end

def self.aumentar_stock (item_facturas)
	item_facturas.each do |item|
		unless item.producto_id.nil?
			# item.tipo = "compra"
			producto  = Producto.find(item.producto_id)
			producto.cantidad_disponible += item.cantidad
			producto.save
		end
	end
end

def rollback_factura
	self.item_facturas.each do |item|
		ingreso_producto = item.ingreso_producto
		ingreso_producto.cantidad = ingreso_producto.cantidad + item.cantidad
		Lineakardex.create(:kardex => ingreso_producto.producto.kardex, :tipo => "Entrada", :fecha => Time.now, :cantidad => item.cantidad, :v_unitario => item.ingreso_producto.precio_venta, :observaciones => "Factura anulada" )
		ingreso_producto.save
	end
end

def militar_servicio
	if self.cliente.militar then self.cliente.militar.servicio else "no tiene un militar asosiado" end
end

def militar_rango
	if self.cliente.militar then self.cliente.militar.rango else "no tiene un militar asosiado" end
end

end

# == Schema Information
#
# Table name: traspasos
#
#  id            :integer          not null, primary key
#  servicio      :string(255)
#  fecha_emision :date             not null
#  numero        :integer          not null
#  iva           :float            not null
#  total         :float            not null
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  subtotal      :float            not null
#  entregado_a   :string(255)
#  subtotal_12   :float            not null
#  razon_anulada :string(255)
#  anulado       :boolean          default(FALSE)
#

class Traspaso < ActiveRecord::Base
	has_many :item_traspasos
	has_many :ingreso_productos, :through => :item_traspasos
  belongs_to :user

	accepts_nested_attributes_for :item_traspasos

	#validations
  validates :servicio, :user_id, :numero, :iva, :total,:fecha_emision, :entregado_a, presence: true
  validates :total, :numericality => { :greater_than_or_equal_to => 0}
  validates :numero, :numericality => { only_integer: true }

  #callbacks
  before_validation :set_transpaso_values
  after_save :add_liquidacion
  
	#methods
	def self.disminuir_stock (item_traspasos)
		item_traspasos.each do |item|
			unless item.producto_id.nil?
				producto  = Producto.find(item.producto_id)
				producto.cantidad_disponible -= item.cantidad
				producto.save
			end
		end
	end

  def set_transpaso_values
    self.numero = Traspaso.last ? Traspaso.last.numero + 1 : 1
    self.fecha_emision = Time.now
		subtotal = 0
		subtotal_12 = 0
		iva = 0
		self.item_traspasos.each do |item|
			unless item.ingreso_producto_id.nil?
				ingreso = IngresoProducto.find item.ingreso_producto_id
				cantidad = item.cantidad #obtiene la cantidad del producto
				item.valor_unitario = ingreso.producto.precio_venta #asigna el valor del item
				item.total = (ingreso.producto.precio_venta * cantidad).round(2) #asigna valor total del item
				if ingreso.producto.hasiva == true
					subtotal_12 = subtotal_12 + item.total
					item.iva = (cantidad * (ingreso.producto.precio_venta * 0.12)).round(2)
				else
					subtotal = subtotal + item.total
					item.iva = 0
				end
				iva = iva + item.iva #suma iva de los productos
			end
		end
		self.iva = iva.round(2)
		self.subtotal = subtotal
		self.subtotal_12 = subtotal_12
		self.total = self.subtotal + self.subtotal_12 + self.iva
		self.total = self.total.round(2)
  end

	def rollback_traspaso
		self.item_traspasos.each do |item|
			ingreso_producto = item.ingreso_producto
			ingreso_producto.cantidad = ingreso_producto.cantidad + item.cantidad
			ingreso_producto.producto.stock = ingreso_producto.producto.stock + item.cantidad #suma al stock si se anula
			Lineakardex.create(:kardex => ingreso_producto.producto.kardex, :tipo => "Entrada", :fecha => Time.now, :cantidad => item.cantidad, :v_unitario => item.ingreso_producto.producto.precio_venta, :modulo => "Traspaso a " + self.servicio, :observaciones => "Transferencia anulada" )
			ingreso_producto.save
			ingreso_producto.producto.save
		end
	end

	def anular_traspaso(razon)
		self.anulado = true
		self.razon_anulada = razon
		self.rollback_traspaso
		self.save
	end

  def add_liquidacion
  	total = 0
  	self.item_traspasos.each do |item|
  		ingreso = IngresoProducto.find item.ingreso_producto_id
  		total = total + (ingreso.producto.precio_compra * item.cantidad).round(2)
  		#obtine el total de la venta sin ganacia
  	end
  	Liquidacion.add_traspaso(self, total)
  end
end

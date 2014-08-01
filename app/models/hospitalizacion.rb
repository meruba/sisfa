# == Schema Information
#
# Table name: hospitalizacions
#
#  id            :integer          not null, primary key
#  fecha_emision :date             not null
#  numero        :integer          not null
#  subtotal      :float            not null
#  iva           :float            not null
#  total         :float            not null
#  user_id       :integer
#  cliente_id    :integer
#  created_at    :datetime
#  updated_at    :datetime
#  descuento     :float
#  subtotal_12   :float            not null
#  dado_de_alta  :boolean          default(FALSE)
#

class Hospitalizacion < ActiveRecord::Base
	has_many :item_hospitalizacions, :order => 'created_at DESC'
	has_many :ingreso_productos, :through => :item_hospitalizacions
  belongs_to :user
  belongs_to :cliente

	accepts_nested_attributes_for :item_hospitalizacions, :allow_destroy => true
	accepts_nested_attributes_for :cliente

	#validations
  validates :user_id, :numero, :iva, :total, :subtotal, :subtotal_12, :fecha_emision, presence: true
  validates :subtotal, :total, :numericality => { :greater_than_or_equal_to => 0}
  validates :numero, :numericality => { only_integer: true }

  #callbacks
	after_create :add_liquidacion
	# after_update :add_item_liquidacion
  # before_validation :set_hospitalizacion_values 
	#methods

	def cliente_attributes=(attributes)
		if attributes['id'].present?
	    self.cliente = Cliente.find(attributes['id'])
	  end
	  super
	end

	def self.disminuir_stock (item_hospitalizacions)
		item_hospitalizacions.each do |item|
			unless item.producto_id.nil?
				producto  = Producto.find(item.producto_id)
				producto.cantidad_disponible -= item.cantidad
				producto.save
			end
		end
	end

	def set_hospitalizacion_values
		self.fecha_emision = Time.now
		self.numero = Hospitalizacion.last ? Hospitalizacion.last.numero + 1 : 1
		subtotal = 0
		subtotal_12 = 0
		iva = 0
		self.item_hospitalizacions.each do |item|
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
		self.descuento = 0
	end

	def add_liquidacion
		Liquidacion.add_hospitalizacion(self)	
	end

	def add_item_liquidacion
		item = self.item_hospitalizacions.first
		ingreso = IngresoProducto.find item.ingreso_producto_id
		total = (ingreso.producto.precio_compra * item.cantidad).round(2)
		# raise
			#obtine el total de la venta sin ganacia
		Liquidacion.add_item_hospitalizacion(self, total)
	end

end

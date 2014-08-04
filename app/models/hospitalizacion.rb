# == Schema Information
#
# Table name: hospitalizacions
#
#  id                          :integer          not null, primary key
#  fecha_emision               :date             not null
#  numero                      :integer          not null
#  subtotal                    :float            not null
#  iva                         :float            not null
#  total                       :float            not null
#  user_id                     :integer
#  created_at                  :datetime
#  updated_at                  :datetime
#  descuento                   :float
#  subtotal_12                 :float            not null
#  hospitalizacion_registro_id :integer
#

class Hospitalizacion < ActiveRecord::Base
	# has_many :item_hospitalizacions, :order => 'created_at DESC'
	has_many :item_hospitalizacions
	has_many :ingreso_productos, :through => :item_hospitalizacions
  belongs_to :hospitalizacion_registro
  belongs_to :user

	accepts_nested_attributes_for :item_hospitalizacions, :allow_destroy => true

	#validations
  # validates :user_id, :numero, :iva, :total, :subtotal, :subtotal_12, :fecha_emision, presence: true
  # validates :subtotal, :total, :numericality => { :greater_than_or_equal_to => 0}
  # validates :numero, :numericality => { only_integer: true }

  #callbacks
	before_create :values_and_liquidacion
	# after_update :add_item_liquidacion
  # before_validation :set_hospitalizacion_values 
	#methods

	def self.disminuir_stock (item_hospitalizacions)
		item_hospitalizacions.each do |item|
			unless item.producto_id.nil?
				producto  = Producto.find(item.producto_id)
				producto.cantidad_disponible -= item.cantidad
				producto.save
			end
		end
	end

	def values_and_liquidacion
		self.fecha_emision = Time.now
		self.numero = Hospitalizacion.last ? Hospitalizacion.last.numero + 1 : 1
		self.user = self.hospitalizacion_registro.doctor.cliente.user
		self.subtotal = 0
		self.subtotal_12 = 0
    self.iva = 0
    self.total = 0
		# raise
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

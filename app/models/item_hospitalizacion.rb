# == Schema Information
#
# Table name: item_hospitalizacions
#
#  id                  :integer          not null, primary key
#  cantidad            :float            not null
#  valor_unitario      :float            not null
#  iva                 :float            not null
#  total               :float            not null
#  descuento           :float
#  created_at          :datetime
#  updated_at          :datetime
#  hospitalizacion_id  :integer
#  ingreso_producto_id :integer
#  pedido_por          :string(255)
#  despachado_por      :string(255)
#  despachado          :boolean          default(FALSE)
#

class ItemHospitalizacion < ActiveRecord::Base

  attr_accessor :descripcion

#relacionships
	belongs_to :hospitalizacion
	belongs_to :ingreso_producto
  
  #rollbacks
  before_save :add_kardex_line, :disminuir_stock, :if => :fue_despachado
  before_save :calculated_values
  
  # validations
  # validates :cantidad, :valor_unitario, :total, :presence => true, :numericality => { :greater_than => 0 }
  validates :cantidad, :presence => true, :numericality => { :greater_than => 0 }
  validate :stock
	
	# methods

  def descripcion
    if self.ingreso_producto
      self.ingreso_producto.producto.nombre
    end
  end

  def fue_despachado
    self.despachado == true
  end

  def calculated_values
    if self.despachado
    subtotal = 0
    subtotal_12 = 0
    iva = 0
    ingreso = IngresoProducto.find self.ingreso_producto_id
    self.valor_unitario = ingreso.producto.precio_venta #asigna el valor del item
    self.total = (ingreso.producto.precio_venta * cantidad).round(2) #asigna valor total del item
    #valores para el comprobante
    if ingreso.producto.hasiva == true
      subtotal_12 = subtotal_12 + self.total
      self.iva = (cantidad * (ingreso.producto.precio_venta * 0.12)).round(2)
    else
      subtotal = subtotal + self.total
      self.iva = 0
    end
    iva = iva + self.iva
    self.hospitalizacion.iva = self.hospitalizacion.iva + iva.round(2)
    self.hospitalizacion.subtotal = self.hospitalizacion.subtotal + subtotal
    self.hospitalizacion.subtotal_12 = self.hospitalizacion.subtotal_12 + subtotal_12
    self.hospitalizacion.total = self.hospitalizacion.subtotal + self.hospitalizacion.subtotal_12 + self.hospitalizacion.iva
    self.hospitalizacion.total = self.hospitalizacion.total.round(2)
    self.hospitalizacion.descuento = 0
    self.hospitalizacion.save
    # valores para la liquidacion
    costo = (ingreso.producto.precio_compra * self.cantidad).round(2)
    iva_item = self.iva
    subtotal_item = subtotal
    subtotal_12_item = subtotal_12
    total_item = self.total
    #metodo para liquidacion
    Liquidacion.add_item_hospitalizacion(self.hospitalizacion,iva_item,subtotal_item,subtotal_12_item,total_item,costo)
    else
    self.valor_unitario = 0
    self.total = 0 
    self.iva = 0 
    end
  end

  def add_item_liquidacion
    total = 0
    raise
    self.item_hospitalizacions.each do |item|
      ingreso = IngresoProducto.find item.ingreso_producto_id
      total = total + (ingreso.producto.precio_compra * item.cantidad).round(2)
      #obtine el total de la venta sin ganacia
    end
    Liquidacion.add_item_hospitalizacion(self, total)
  end

  def stock
    unless self.cantidad.nil?
      if self.cantidad > IngresoProducto.find(self.ingreso_producto_id).cantidad
        errors.add :cantidad, "Stock insuficiente de: " + ingreso_producto.producto.nombre + " / " + ingreso_producto.cantidad.to_s
      end
    end
  end

  def add_kardex_line
    Lineakardex.create(:kardex => self.ingreso_producto.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => self.cantidad, :v_unitario => self.ingreso_producto.producto.precio_venta, :modulo => "Hospitalizacion" )
  end

  private
  def disminuir_stock
    disminuido = IngresoProducto.find(self.ingreso_producto_id)
    disminuido.cantidad -= self.cantidad
    disminuido.save
    self.ingreso_producto.producto.update(:stock  => self.ingreso_producto.producto.stock - self.cantidad)
  end

end

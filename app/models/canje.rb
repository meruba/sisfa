# == Schema Information
#
# Table name: canjes
#
#  id            :integer          not null, primary key
#  antiguo_id    :integer
#  nuevo_id      :integer
#  producto_id   :integer
#  fecha         :datetime
#  created_at    :datetime
#  updated_at    :datetime
#  tipo          :string(255)
#  cantidad      :float            not null
#  precio_salida :float            not null
#  total         :float            not null
#

class Canje < ActiveRecord::Base
  #relationship
    belongs_to :antiguo, :class_name => "IngresoProducto", :foreign_key => "antiguo_id", :inverse_of => :antiguos
    belongs_to :nuevo, :class_name => "IngresoProducto", :foreign_key => "nuevo_id", :inverse_of => :nuevos
    belongs_to :producto

#validations
	validates :fecha, :tipo, :presence =>true, :if => :changing_with_same

# nested
  accepts_nested_attributes_for :nuevo, :reject_if => :changing_with_other
  accepts_nested_attributes_for :producto, :reject_if => :changing_with_same

#callbacks
  before_validation :set_values

#methods
  
  def changing_with_same
    self.tipo == "mismo_producto"
  end

  def changing_with_other
    self.tipo == "otro_producto"
  end

  def nuevo_attributes=(attributes)
    if attributes['id'].present?
      self.nuevo = IngresoProducto.find(attributes['id'])
    else
      attributes['cantidad'] = self.antiguo.cantidad
      attributes['producto_id'] = self.antiguo.producto_id
    end
    super
  end

  def producto_attributes=(attributes)
    if attributes['id'].present?
      self.producto = Producto.find(attributes['id'])
    end
    super
  end

  private

  def set_values
    self.fecha = Time.now
    self.cantidad = self.antiguo.cantidad
    self.precio_salida = self.antiguo.producto.precio_compra
    self.total = self.precio_salida * self.cantidad
    Lineakardex.create(:kardex => self.antiguo.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => self.antiguo.cantidad, :v_unitario => self.antiguo.producto.precio_compra, :observaciones => "Producto Canjeado")     
    self.antiguo.cantidad = 0
    self.antiguo.save 
  end
end

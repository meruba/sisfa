# == Schema Information
#
# Table name: canjes
#
#  id          :integer          not null, primary key
#  antiguo_id  :integer
#  nuevo_id    :integer
#  producto_id :integer
#  fecha       :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  tipo        :string(255)
#

class Canje < ActiveRecord::Base
  #relationships
    belongs_to :antiguo, :class_name => "IngresoProducto"
    belongs_to :nuevo, :class_name => "IngresoProducto"
    belongs_to :producto

#validations
	validates :fecha, :tipo, :presence =>true

#callbacks
  # after_create :set_lineas_kardex

#methods

  def mismo_producto(attrs, producto_a_canjear)
    ingreso = IngresoProducto.new(:lote => attrs[:lote], :fecha_caducidad => attrs[:fecha_caducidad], :producto => producto_a_canjear.producto, :cantidad => producto_a_canjear.cantidad)
    ingreso.save
    self.antiguo = producto_a_canjear
    self.nuevo = ingreso
    Lineakardex.create(:kardex => producto_a_canjear.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => producto_a_canjear.cantidad, :v_unitario => producto_a_canjear.producto.precio_compra, :observaciones => "Producto Canjeado")
    producto_a_canjear.cantidad = 0
    producto_a_canjear.save  
  end

  def otro_producto(attrs, producto_a_canjear)
    producto = Producto.find(attrs[:id])
    producto.ingreso_productos.create(
      :fecha_caducidad => attrs[:ingreso_productos][:fecha_caducidad],
      :cantidad => attrs[:ingreso_productos][:cantidad],
      :lote => attrs[:ingreso_productos][:lote]
      )
    self.antiguo = producto_a_canjear
    self.nuevo = producto.ingreso_productos.last
    Lineakardex.create(:kardex => self.antiguo.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => self.antiguo.cantidad, :v_unitario => self.antiguo.producto.precio_compra, :observaciones => "Producto Canjeado")
    producto_a_canjear.cantidad = 0
    producto_a_canjear.save
  end

  # private

  # def set_lineas_kardex
  #   Lineakardex.create(:kardex => self.antiguo.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => self.antiguo.cantidad, :v_unitario => self.antiguo.producto.precio_compra, :observaciones => "Producto Canjeado")
  # end

end

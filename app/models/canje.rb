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
    belongs_to :entrada_antigua, :class_name => "IngresoProducto"
    belongs_to :entrada_nueva, :class_name => "IngresoProducto"
    belongs_to :producto

#validations
	# validates :fecha, :tipo, :presence =>true
	
#callbacks
  after_create :set_lineas_kardex
  after_create :set_values

#methods
  private

  def find_ingreso
		ingreso = IngresoProducto.find(self.antiguo_id)
  end

	def set_values
  	ingreso = find_ingreso()
	  self.fecha = Time.now
  	self.antiguo_id = ingreso.id
  	self.producto_id = ingreso.producto.id
	end

  def set_lineas_kardex
  	ingreso = find_ingreso()
    Lineakardex.create(:kardex => ingreso.producto.kardex, :tipo => "Entrada", :fecha => Time.now, :cantidad => ingreso.cantidad, :v_unitario => ingreso.producto.precio_compra, :observaciones => "Canje de producto")
    Lineakardex.create(:kardex => ingreso.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => ingreso.cantidad, :v_unitario => ingreso.producto.precio_compra, :observaciones => "Producto Caducado")
  end
end

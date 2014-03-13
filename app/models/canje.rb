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
  after_create :set_values
  after_save :set_salida_kardex, :update_producto

#methods
  private

  def find_ingreso
		ingreso = IngresoProducto.find(self.antiguo_id)
  end

	def set_values
  	ingreso = find_ingreso()
	  self.fecha = Time.now
  	self.producto_id = ingreso.producto.id
	end

  def set_salida_kardex
  	ingreso = find_ingreso()
    Lineakardex.create(:kardex => ingreso.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => ingreso.cantidad, :v_unitario => ingreso.producto.precio_compra, :observaciones => "Producto Caducado")
  end

  def update_producto
  	ingreso = find_ingreso()
    IngresoProducto.create(:producto_id => ingreso.producto.id, :cantidad => ingreso.cantidad, :fecha_caducidad => "2015/06/23", :lote => "234")
    ingreso.update(:cantidad => '0')
  end
end

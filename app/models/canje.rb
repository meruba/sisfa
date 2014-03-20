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
	validates :fecha, :tipo, :presence =>true
	
#callbacks
  # after_create :set_values
  # after_save :set_salida_kardex, :update_producto

#methods
  def mismo_producto(fecha,lote)
    self.fecha = Time.now
    self.tipo = "Mismo Producto"
    ingreso  = find_ingreso()
    Lineakardex.create(:kardex => ingreso.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => ingreso.cantidad, :v_unitario => ingreso.producto.precio_compra, :observaciones => "Producto Caducado")
    IngresoProducto.create(:producto_id => ingreso.producto.id, :cantidad => ingreso.cantidad, :fecha_caducidad => fecha, :lote => lote)
    ingreso.update(:cantidad => '0')
  end

  private

  def find_ingreso
		ingreso = IngresoProducto.find(self.antiguo_id)
  end
end

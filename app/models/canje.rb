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
	validates :fecha, :tipo, :antiguo_id, :producto_id, :presence =>true
	
#callbacks
  after_create :set_lineas_kardex

#methods
  private

  def find_ingreso(id)
		ingreso = IngresoProducto.find(id)
  end

  def set_lineas_kardex
  	ingreso  = find_ingreso(antiguo_id)
    Lineakardex.create(:kardex => self.producto.kardex, :tipo => "Entrada", :fecha => Time.now, :cantidad => ingreso.cantidad, :v_unitario => self.producto.precio_compra, :observaciones => "Canje de producto")
    Lineakardex.create(:kardex => self.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => ingreso.cantidad, :v_unitario => self.producto.precio_compra, :observaciones => "Producto Caducado")
  end
end

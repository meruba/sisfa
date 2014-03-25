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
	# validates :fecha, :tipo, :presence =>true
	
#callbacks
  after_create :set_lineas_kardex

#methods
  private

  def set_lineas_kardex
    Lineakardex.create(:kardex => self.antiguo.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => self.antiguo.cantidad, :v_unitario => self.antiguo.producto.precio_compra, :observaciones => "Producto Canjeado")
  end

end

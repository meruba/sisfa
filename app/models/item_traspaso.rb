# == Schema Information
#
# Table name: item_traspasos
#
#  id                  :integer          not null, primary key
#  cantidad            :float            not null
#  valor_unitario      :float            not null
#  total               :float            not null
#  created_at          :datetime
#  updated_at          :datetime
#  traspaso_id         :integer
#  ingreso_producto_id :integer
#

class ItemTraspaso < ActiveRecord::Base

#relacionships
	belongs_to :traspaso
	belongs_to :ingreso_producto
  
  #rollbacks
  after_create :add_kardex_line, :disminuir_stock
  
  # validations
  validates :cantidad, :valor_unitario, :total, :presence => true, :numericality => { :greater_than => 0 }
  validate :stock
	
	# methods
	def stock
	  if self.cantidad > IngresoProducto.find(self.ingreso_producto_id).cantidad
	  	errors.add :cantidad, "No hay suficiente stock de: " + ingreso_producto.producto.nombre
	  end
	end

  def add_kardex_line
    Lineakardex.create(:kardex => self.ingreso_producto.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => self.cantidad, :v_unitario => self.ingreso_producto.producto.precio_venta, :modulo => "Traspaso a " + self.traspaso.servicio )
  end

  private
  def disminuir_stock
    disminuido = IngresoProducto.find(self.ingreso_producto_id)
    disminuido.cantidad -= self.cantidad
    disminuido.save
  end

end

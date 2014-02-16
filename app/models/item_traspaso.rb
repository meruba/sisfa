# == Schema Information
#
# Table name: item_traspasos
#
#  id             :integer          not null, primary key
#  cantidad       :float            not null
#  valor_unitario :float            not null
#  total          :float            not null
#  iva            :float            not null
#  producto_id    :integer
#  created_at     :datetime
#  updated_at     :datetime
#  traspaso_id    :integer
#

class ItemTraspaso < ActiveRecord::Base
	belongs_to :traspaso
	belongs_to :producto
  
  #rollbacks
  after_create :add_kardex_line
  
  # validations
  validates :cantidad, :valor_unitario, :total, :presence => true, :numericality => { :greater_than => 0 }
  validate :stock
	
	# methods
	def stock
	  if self.cantidad > producto.cantidad_disponible
	  	errors.add :cantidad, "No hay suficiente stock de: " + producto.nombre
	  end
	end

  def add_kardex_line
    Lineakardex.create(:kardex => self.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => self.cantidad, :v_unitario => self.producto.precio_venta, :modulo => "Traspaso a " + self.traspaso.servicio )
  end

end

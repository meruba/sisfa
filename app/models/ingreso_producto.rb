# == Schema Information
#
# Table name: ingreso_productos
#
#  id              :integer          not null, primary key
#  lote            :string(255)
#  fecha_caducidad :date
#  precio_compra   :decimal(4, 2)    not null
#  precio_venta    :decimal(4, 2)
#  cantidad        :integer
#  ganancia        :float
#  producto_id     :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class IngresoProducto < ActiveRecord::Base
  
#relationships
  belongs_to :producto

#validations
  validates :cantidad, :ganancia, :precio_compra, :fecha_caducidad, :presence => true
  validates :cantidad, :precio_compra, :ganancia, :numericality => { :greater_than_or_equal_to => 0}

#callbacks
  before_create :set_precios
  before_update :set_precios
  after_create :set_entrada_kardex
  before_destroy :set_salida_kardex

#methods
  private
  def set_precios
    precio_compra_iva = self.precio_compra * 0.12 + self.precio_compra
    self.precio_venta = precio_compra_iva * self.ganancia/100 + precio_compra_iva
  end

  def set_entrada_kardex
    Lineakardex.create(:kardex => self.producto.kardex, :tipo => "Entrada", :fecha => Time.now, :cantidad => self.cantidad, :v_unitario => self.precio_compra )
  end

  def set_salida_kardex
    Lineakardex.create(:kardex => self.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => self.cantidad, :v_unitario => self.precio_compra, :observaciones => "Eliminado desde producto" )
  end
end

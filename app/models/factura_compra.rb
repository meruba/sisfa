# == Schema Information
#
# Table name: factura_compras
#
#  id                   :integer          not null, primary key
#  proveedor_id         :integer
#  user_id              :integer
#  numero               :integer
#  observacion          :string(255)
#  fecha_de_emision     :datetime
#  fecha_de_vencimiento :datetime
#  subtotal_0           :float            not null
#  iva                  :float            not null
#  total                :float            not null
#  created_at           :datetime
#  updated_at           :datetime
#  subtotal_12          :float
#

class FacturaCompra < ActiveRecord::Base
  belongs_to :proveedor
  belongs_to :user
  has_many :factura_compras_productos
  has_many :productos, :through => :factura_compras_productos
  accepts_nested_attributes_for :factura_compras_productos, :proveedor
  
  #callbacks
  before_save :set_values
  after_save :add_liquidacion

  def proveedor_attributes=(attributes)
    if attributes['id'].present?
      self.proveedor = Proveedor.find(attributes['id'])
    end
    super
  end

  def set_values
    self.fecha_de_emision = Time.now
    self.fecha_de_vencimiento = Time.now + 30.days
  end

  def add_liquidacion
    Liquidacion.add_compra(self)
  end
end

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
#

class FacturaCompra < ActiveRecord::Base
  belongs_to :proveedor
  belongs_to :user
  has_many :factura_compras_productos
  has_many :productos, :through => :factura_compras_productos
  accepts_nested_attributes_for :factura_compras_productos
  before_save :set_values


  def set_values
    # self.user_id = current_user.id
    self.fecha_de_emision = Time.now
    self.fecha_de_vencimiento = Time.now + 30.days
  end
end

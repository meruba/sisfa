# == Schema Information
#
# Table name: proformas
#
#  id                   :integer          not null, primary key
#  numero               :integer          not null
#  observacion          :string(255)
#  fecha_de_emision     :datetime         not null
#  fecha_de_vencimiento :datetime         not null
#  subtotal_0           :float            not null
#  subtotal_12          :float            not null
#  descuento            :float            not null
#  iva                  :float            not null
#  total                :float            not null
#  created_at           :datetime
#  updated_at           :datetime
#  cliente_id           :integer          not null
#  tipo                 :string(255)      not null
#  anulada              :boolean          default(FALSE)
#

class Proforma < ActiveRecord::Base
#relations
belongs_to :cliente
belongs_to :proveedor
has_many :item_proformas
has_many :productos, :through => :item_proformas

#nested
# accepts_nested_attributes_for :cliente
accepts_nested_attributes_for :item_proformas

#valitations
validates :numero, :fecha_de_emision, :fecha_de_vencimiento, :subtotal_0, :subtotal_12, :descuento, :iva, :total, :presence =>true
validates :numero, :subtotal_0, :subtotal_12, :descuento, :iva, :total, :numericality => true, :numericality => { :greater_than_or_equal_to => 0 }

#methods
item_proformas = []
def self.disminuir_stock (item_proformas)
  item_proformas.each do |item|
    unless item.producto_id.nil?
      producto  = Producto.find(item.producto_id)
      producto.cantidad_disponible -= item.cantidad
      producto.save
    end
  end
  # item_proformas.each do |value, key|
  #   producto  = Producto.find("#{key[:producto_id]}")
  #   cantidad_item = item_facturas[value][:cantidad].to_f
  #   producto.cantidad_disponible -= cantidad_item
  #   raise 'error'
  #   producto.save
  # end
end

end

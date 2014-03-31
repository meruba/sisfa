# == Schema Information
#
# Table name: factura_compras_productos
#
#  id                :integer          not null, primary key
#  factura_compra_id :integer
#  producto_id       :integer
#

class FacturaComprasProducto < ActiveRecord::Base
  
  #relationships
    belongs_to :producto
    belongs_to :factura_compra
  
  #validations
    validates_presence_of :producto
  
  #nested attributes
    accepts_nested_attributes_for :producto
  
  #methods
    def producto_attributes=(attributes)
      if attributes['id'].present?
        self.producto = Producto.find(attributes['id'])
      end
      super
    end
end

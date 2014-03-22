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
  
  #callbacks
    before_validation :set_selected_producto

  #methods
    private
    def set_selected_producto
      if producto_id && producto_id != '0'
        self.producto = Producto.find(producto_id)
      end
    end
end

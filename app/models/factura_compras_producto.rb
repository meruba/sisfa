# == Schema Information
#
# Table name: factura_compras_productos
#
#  id                :integer          not null, primary key
#  factura_compra_id :integer
#  producto_id       :integer
#  cantidad          :float            not null
#  valor_unitario    :float            not null
#  iva               :float            not null
#  total             :float            not null
#

class FacturaComprasProducto < ActiveRecord::Base

  #relationships
    belongs_to :producto
    belongs_to :factura_compra

  #validations
    validates_presence_of :producto
    validates :cantidad, :iva, :total, :presence =>true

  #nested attributes
    accepts_nested_attributes_for :producto

  #methods
  def producto_attributes=(attributes)
    cantidad = 0
    if attributes['id'].present?
      self.producto = Producto.find(attributes['id'])
      if attributes[:ingreso_productos_attributes].blank? == false
        attributes[:ingreso_productos_attributes].each do |value,key|
          cantidad = cantidad + key[:cantidad].to_f
        end
      end 
      if attributes['hasiva'] == "0"
        iva = 0
      else
        iva = (attributes['precio_compra'].to_f * 0.12).round(2)
      end
      self.cantidad = cantidad
      self.valor_unitario = producto.precio_compra
      self.iva  = iva
      self.total = self.valor_unitario * self.cantidad
    else
      if attributes['hasiva'] == "0"
        iva = 0
      else
        iva = (attributes['precio_compra'].to_f * 0.12).round(2)
      end
      if attributes[:ingreso_productos_attributes].blank? == false
        attributes[:ingreso_productos_attributes].each do |value,key|
          cantidad = cantidad + key[:cantidad].to_f
        end
        self.cantidad = cantidad
        self.valor_unitario = attributes['precio_compra']
        self.iva = iva
        self.total = self.cantidad * self.valor_unitario
      end
    end
    super
  end
end

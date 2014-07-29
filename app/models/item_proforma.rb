# == Schema Information
#
# Table name: item_proformas
#
#  id                  :integer          not null, primary key
#  created_at          :datetime
#  updated_at          :datetime
#  cantidad            :float            not null
#  valor_unitario      :float            not null
#  descuento           :float
#  iva                 :float
#  proforma_id         :integer          not null
#  total               :float            not null
#  ingreso_producto_id :integer
#

class ItemProforma < ActiveRecord::Base
  
  #relationships
  belongs_to :proforma
  belongs_to :ingreso_producto

  # validations:
  validates :cantidad, :valor_unitario, :total, :presence => true,
                                                            :numericality => { :greater_than_or_equal_to => 0 }
                                                   
  # validate :valida_descuento
  validate :stock

  def descripcion
    if self.ingreso_producto
      self.ingreso_producto.producto.nombre
    end
  end

  # methods

  def valida_descuento
    if self.descuento > self.total
      errors.add :descuento, "descuento no valido en:" + ingreso_producto.producto.nombre
    end
  end

  def stock
    sin_id = IngresoProducto.find_by_id(self.ingreso_producto_id).nil?
    if sin_id == false
      if self.cantidad > IngresoProducto.find(self.ingreso_producto_id).cantidad
      errors.add :cantidad, "Stock insuficiente de: " + ingreso_producto.producto.nombre + " / " + ingreso_producto.cantidad.to_s
      end
    else
      errors.add :ingreso_producto_id, "Tienes items en blanco"
    end
  end
end

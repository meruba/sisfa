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
  validates :cantidad, :valor_unitario, :total, :descuento, :presence => true,
                                                            :numericality => { :greater_than_or_equal_to => 0 }
                                                   
  validate :valida_descuento
  validate :stock

  # methods

  def valida_descuento
    if self.descuento > self.total
      errors.add :descuento, "descuento no valido en:" + ingreso_producto.producto.nombre
    end
  end

  def stock
    if self.cantidad > IngresoProducto.find(self.ingreso_producto_id).cantidad
      errors.add :cantidad, "No hay suficiente stock de: " + ingreso_producto.producto.nombre
    end
  end

end

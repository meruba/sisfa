# == Schema Information
#
# Table name: item_proformas
#
#  id             :integer          not null, primary key
#  cantidad       :integer          not null
#  valor_unitario :float            not null
#  descuento      :float
#  iva            :float            not null
#  total          :float            not null
#  created_at     :datetime
#  updated_at     :datetime
#  producto_id    :integer          not null
#  factura_id     :integer          not null
#

class ItemProforma < ActiveRecord::Base
  
  #relationships
  belongs_to :proforma
  belongs_to :producto

  # validations:
  validates :cantidad, :valor_unitario, :total, :descuento, :presence => true,
                                                            :numericality => { :greater_than_or_equal_to => 0 }
                                                   
  validate :valida_descuento

  # methods

  def valida_descuento
    if self.descuento > self.total
      errors.add :descuento, "descuento no valido en:" + producto.nombre
    end
  end
end

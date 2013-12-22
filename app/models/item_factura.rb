class ItemFactura < ActiveRecord::Base
  
  #relationships
  belongs_to :factura
  belongs_to :producto

	# validations:
  validates :cantidad, :valor_unitario, :total, :descuento, :presence => true,
                                                            :numericality => { :greater_than_or_equal_to => 0 }
  validate :stock                                                            
  validate :valida_descuento

  # methods
  def stock
    if self.cantidad > producto.cantidad_disponible
      errors.add :cantidad, "No hay suficiente stock de: " + producto.nombre
    end
  end

  def valida_descuento
    if self.descuento > self.total
      errors.add :descuento, "descuento no valido en:" + producto.nombre
    end
  end
end

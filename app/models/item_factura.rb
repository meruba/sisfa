# == Schema Information
#
# Table name: item_facturas
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
#  tipo           :string(255)
#

class ItemFactura < ActiveRecord::Base
  
  #rollbacks
  after_create :add_kardex_line

  #relationships
  belongs_to :factura
  belongs_to :producto

	# validations:
  validates :tipo, :presence => true
  validates :cantidad, :valor_unitario, :total, :descuento, :presence => true,
                                                            :numericality => { :greater_than_or_equal_to => 0 }
  validate :stock                                                            
  validate :valida_descuento

  # methods
  def stock
    if self.tipo != "compra"
      if self.cantidad > producto.cantidad_disponible
        errors.add :cantidad, "No hay suficiente stock de: " + producto.nombre
      end
    end
  end

  def valida_descuento
    if self.descuento > self.total
      errors.add :descuento, "descuento no valido en:" + producto.nombre
    end
  end

  def add_kardex_line
    if self.tipo != "compra"
      Lineakardex.create(:kardex => self.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => self.cantidad, :v_unitario => self.producto.precio_compra, :modulo => self.factura.tipo_venta )
    end
  end

end

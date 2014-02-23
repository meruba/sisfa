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
  attr_accessor :producto_entrada_id
  
  #callbacks
  after_create :add_kardex_line, :disminuir_stock

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
      if self.cantidad > IngresoProducto.find(self.producto_entrada_id).cantidad
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
      Lineakardex.create(:kardex => self.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => self.cantidad, :v_unitario => IngresoProducto.find(self.producto_entrada_id).precio_venta, :modulo => self.factura.tipo_venta.capitalize )
    else   
      Lineakardex.create(:kardex => self.producto.kardex, :tipo => "Entrada", :fecha => Time.now, :cantidad => self.cantidad, :v_unitario => self.producto.precio_compra, :observaciones => "Factura de compra")
    end
  end

  private

  def disminuir_stock
    disminuido = IngresoProducto.find(self.producto_entrada_id)
    disminuido.cantidad -= self.cantidad
    disminuido.save
  end

end

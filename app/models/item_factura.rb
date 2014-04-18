# == Schema Information
#
# Table name: item_facturas
#
#  id                  :integer          not null, primary key
#  cantidad            :integer          not null
#  valor_unitario      :float            not null
#  descuento           :float
#  iva                 :float            not null
#  total               :float            not null
#  created_at          :datetime
#  updated_at          :datetime
#  factura_id          :integer          not null
#  tipo                :string(255)
#  ingreso_producto_id :integer
#

class ItemFactura < ActiveRecord::Base
  
  #callbacks
  after_create :add_kardex_line, :disminuir_stock

  #relationships
  belongs_to :factura
  belongs_to :ingreso_producto

	# validations:
  validates :tipo, :presence => true
  validates :cantidad, :valor_unitario, :total, :presence => true,
                                                            :numericality => { :greater_than_or_equal_to => 0 }
  validate :stock                                                            
  # validate :valida_descuento

  # methods
  def stock
    sin_id = IngresoProducto.find_by_id(self.ingreso_producto_id).nil?
    if sin_id == false
      if self.cantidad > IngresoProducto.find(self.ingreso_producto_id).cantidad
      errors.add :cantidad, "No hay suficiente stock de: " + ingreso_producto.producto.nombre
      end
    else
      errors.add :ingreso_producto_id, "Tienes items en blanco"
    end
  end

  def valida_descuento
    if self.descuento > self.total
      errors.add :descuento, "descuento no valido en:" + ingreso_producto.producto.nombre
    end
  end

  def add_kardex_line
    Lineakardex.create(:kardex => self.ingreso_producto.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => self.cantidad, :v_unitario => self.ingreso_producto.producto.precio_venta, :modulo => "Ventanilla" )
  end

  private

  def disminuir_stock
    disminuido = IngresoProducto.find(self.ingreso_producto_id)
    disminuido.cantidad -= self.cantidad
    disminuido.save
    self.ingreso_producto.producto.update(:stock  => self.ingreso_producto.producto.stock - self.cantidad)
  end

end

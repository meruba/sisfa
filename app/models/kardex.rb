# == Schema Information
#
# Table name: kardexes
#
#  id          :integer          not null, primary key
#  fecha       :date
#  created_at  :datetime
#  updated_at  :datetime
#  producto_id :integer          not null
#

class Kardex < ActiveRecord::Base

#callbacks
  after_create :set_first_item

#validations
  validates :fecha, :presence => true

#relations
  has_many :lineakardexes
  belongs_to :producto

#methods
  def set_first_item
    unless self.producto.ingreso_productos.empty?
      Lineakardex.create(:kardex => self, :tipo => "Entrada", :fecha => Time.now, :cantidad => self.producto.ultimo_registro_compra.cantidad, :v_unitario => self.producto.ultimo_registro_compra.precio_compra )
    end
  end

end

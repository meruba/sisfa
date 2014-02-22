# == Schema Information
#
# Table name: ingreso_productos
#
#  id              :integer          not null, primary key
#  lote            :string(255)
#  fecha_caducidad :date
#  precio_compra   :decimal(4, 2)    not null
#  precio_venta    :decimal(4, 2)
#  cantidad        :integer
#  ganancia        :float
#  producto_id     :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class IngresoProducto < ActiveRecord::Base
  belongs_to :producto
  validates :cantidad, :ganancia, :precio_compra, :fecha_caducidad, :presence => true
  validates :cantidad, :precio_compra, :ganancia, :numericality => { :greater_than_or_equal_to => 0}
end

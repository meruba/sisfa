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
end

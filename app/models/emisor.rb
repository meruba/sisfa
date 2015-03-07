# == Schema Information
#
# Table name: emisors
#
#  id                       :integer          not null, primary key
#  nombre_establecimiento   :string(255)
#  ruc                      :string(255)
#  numero_inicial_factura   :integer
#  created_at               :datetime
#  updated_at               :datetime
#  saldo_inicial_inventario :float
#  otros_dias               :boolean          default(FALSE)
#  numero_turnos_fisiatria  :integer
#

class Emisor < ActiveRecord::Base
  validates :nombre_establecimiento, :ruc, :numero_inicial_factura, :presence => true

  after_create :add_saldo_inicial_to_liquidacion

  def self.numero_inicial
    @@numero_inicial = if Emisor.first then Emisor.first.numero_inicial_factura else nil end
  end

  def add_saldo_inicial_to_liquidacion
  	Liquidacion.first_liquidacion(self.saldo_inicial_inventario)
  end
end

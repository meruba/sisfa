# == Schema Information
#
# Table name: emisors
#
#  id                     :integer          not null, primary key
#  nombre_establecimiento :string(255)
#  ruc                    :string(255)
#  numero_inicial_factura :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class Emisor < ActiveRecord::Base
  validates :nombre_establecimiento, :ruc, :numero_inicial_factura, :presence => true

  def self.numero_inicial
    @@numero_inicial = if Emisor.first then Emisor.first.numero_inicial_factura else nil end
  end
end

# == Schema Information
#
# Table name: cierre_cajas
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  is_cerrado :boolean
#  created_at :datetime
#  updated_at :datetime
#

class CierreCaja < ActiveRecord::Base
  belongs_to :user
  has_many :cierre_caja_items

  def sumatoria
    sumatoria = 0
    self.cierre_caja_items.each do |cierre_caja|
      sumatoria += cierre_caja.factura.total
    end
    sumatoria
  end

  def subtotal12
    sumatoria = 0
    self.cierre_caja_items.each do |cierre_caja|
      sumatoria += cierre_caja.factura.subtotal_12
    end
    sumatoria
  end

  def subtotal0
    sumatoria = 0
    self.cierre_caja_items.each do |cierre_caja|
      sumatoria += cierre_caja.factura.subtotal_12
    end
    sumatoria
  end

  def sumatoriaiva
    sumatoria = 0
    self.cierre_caja_items.each do |cierre_caja|
      sumatoria += cierre_caja.factura.iva
    end
    sumatoria
  end

end

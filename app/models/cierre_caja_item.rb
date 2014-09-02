# == Schema Information
#
# Table name: cierre_caja_items
#
#  id             :integer          not null, primary key
#  factura_id     :integer
#  cierre_caja_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class CierreCajaItem < ActiveRecord::Base
  belongs_to :factura
  belongs_to :cierre_caja
end

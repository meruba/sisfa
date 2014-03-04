# == Schema Information
#
# Table name: itemfacturacompras
#
#  id          :integer          not null, primary key
#  producto_id :integer
#  factura_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Itemfacturacompra < ActiveRecord::Base
  belongs_to :producto
  belongs_to :factura
end

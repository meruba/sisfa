# == Schema Information
#
# Table name: cierre_cajas
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  factura_id :integer
#  is_cerrado :boolean
#  created_at :datetime
#  updated_at :datetime
#

class CierreCaja < ActiveRecord::Base
  belongs_to :user
  belongs_to :factura
end

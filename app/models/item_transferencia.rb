# == Schema Information
#
# Table name: item_transferencia
#
#  id             :integer          not null, primary key
#  cantidad       :float            not null
#  valor_unitario :float            not null
#  total          :float            not null
#  iva            :float            not null
#  producto_id    :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class ItemTransferencia < ActiveRecord::Base
  belongs_to :transferencia
  belongs_to :producto

  # validations:
  validates :cantidad, :valor_unitario, :total, :presence => true, :numericality => { :greater_than => 0 }
end

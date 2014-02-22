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

def set_first_item
  Lineakardex.create(:kardex => self, :tipo => "Entrada", :fecha => Time.now, :cantidad => self.producto.cantidad_para_kardex, :v_unitario => self.producto.precio_compra )
end
end

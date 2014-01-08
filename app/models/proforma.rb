# == Schema Information
#
# Table name: proformas
#
#  id                   :integer          not null, primary key
#  numero               :integer          not null
#  observacion          :string(255)
#  fecha_de_emision     :datetime         not null
#  fecha_de_vencimiento :datetime         not null
#  subtotal_0           :float            not null
#  subtotal_12          :float            not null
#  descuento            :float            not null
#  iva                  :float            not null
#  total                :float            not null
#  created_at           :datetime
#  updated_at           :datetime
#  cliente_id           :integer          not null
#  tipo                 :string(255)      not null
#  anulada              :boolean          default(FALSE)
#

class Proforma < ActiveRecord::Base
#relations
belongs_to :cliente
has_many :item_proformas
has_many :productos, :through => :item_proformas

#nested
accepts_nested_attributes_for :item_proformas

#valitations
validates :numero, :fecha_de_emision, :subtotal_0, :subtotal_12, :descuento, :iva, :total, :presence =>true
validates :numero, :subtotal_0, :subtotal_12, :descuento, :iva, :total, :numericality => true, :numericality => { :greater_than_or_equal_to => 0 }

#methods

end

# == Schema Information
#
# Table name: proformas
#
#  id            :integer          not null, primary key
#  fecha_emision :date             not null
#  numero        :integer          not null
#  iva           :float            not null
#  subtotal_0    :float            not null
#  subtotal_12   :float            not null
#  descuento     :float            not null
#  total         :float            not null
#  created_at    :datetime
#  updated_at    :datetime
#  cliente_id    :integer          not null
#

class Proforma < ActiveRecord::Base
#relations
belongs_to :cliente
has_many :item_proformas
has_many :ingreso_productos, :through => :item_proformas

#nested
accepts_nested_attributes_for :item_proformas

#valitations
validates :numero, :fecha_emision, :subtotal_0, :subtotal_12, :descuento, :iva, :total, :presence =>true
validates :numero, :subtotal_0, :subtotal_12, :descuento, :iva, :total, :numericality => true, :numericality => { :greater_than_or_equal_to => 0 }

#methods

end

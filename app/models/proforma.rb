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
#

class Proforma < ActiveRecord::Base
#validations
	validates :fecha_emision, :numero, :iva, :subtotal_0, :subtotal_12, :descuento, :total, :presence =>true
	validates :numero, :iva, :subtotal_0, :subtotal_12, :descuento, :total, :numericality => true, :numericality => { :greater_than_or_equal_to =>0 }
#relations
	belongs_to :cliente
	has_many :item_proformas
	has_many :productos, :through => :item_proformas
		
end

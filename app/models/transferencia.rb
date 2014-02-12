# == Schema Information
#
# Table name: transferencia
#
#  id            :integer          not null, primary key
#  servicio      :string(255)
#  fecha_emision :date             not null
#  numero        :integer          not null
#  iva           :float            not null
#  total         :float            not null
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Transferencia < ActiveRecord::Base
	has_many :item_transferencias
	has_many :productos, :through => :item_transferencias

	accepts_nested_attributes_for :item_transferencias
end

# == Schema Information
#
# Table name: traspasos
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

class Traspaso < ActiveRecord::Base
	has_many :item_traspasos
	has_many :productos, :through => :item_traspasos
  belongs_to :user

	accepts_nested_attributes_for :item_traspasos
end

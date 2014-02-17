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

	#validations
  validates :servicio, :user_id, :numero, :iva, :total,:fecha_emision, presence: true
  validates :total, :numericality => { :greater_than_or_equal_to => 0}
  validates :numero, :numericality => { only_integer: true }

	#methods
	item_traspasos = []
	def self.disminuir_stock (item_traspasos)
		item_traspasos.each do |item|
			unless item.producto_id.nil?
				producto  = Producto.find(item.producto_id)
				producto.cantidad_disponible -= item.cantidad
				producto.save
			end
		end
	end
end

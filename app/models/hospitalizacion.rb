# == Schema Information
#
# Table name: hospitalizacions
#
#  id            :integer          not null, primary key
#  fecha_emision :date             not null
#  numero        :integer          not null
#  subtotal      :float            not null
#  iva           :float            not null
#  total         :float            not null
#  user_id       :integer
#  cliente_id    :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Hospitalizacion < ActiveRecord::Base
	has_many :item_hospitalizacions
	has_many :ingreso_productos, :through => :item_hospitalizacions
  belongs_to :user

	accepts_nested_attributes_for :item_hospitalizacions

	#validations
  validates :user_id, :numero, :iva, :total, :subtotal, :fecha_emision, presence: true
  validates :subtotal, :total, :numericality => { :greater_than_or_equal_to => 0}
  validates :numero, :numericality => { only_integer: true }

	#methods
	def self.disminuir_stock (item_hospitalizacions)
		item_hospitalizacions.each do |item|
			unless item.producto_id.nil?
				producto  = Producto.find(item.producto_id)
				producto.cantidad_disponible -= item.cantidad
				producto.save
			end
		end
	end
end

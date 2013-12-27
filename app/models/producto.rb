# == Schema Information
#
# Table name: productos
#
#  id                  :integer          not null, primary key
#  nombre              :string(255)      not null
#  precio_a            :float            not null
#  codigo              :string(255)
#  categoria           :string(255)
#  descripcion         :string(255)
#  fecha_de_caducidad  :date
#  casa_comercial      :string(255)
#  nombre_generico     :string(255)
#  precio_b            :float
#  precio_c            :float
#  cantidad_disponible :float            not null
#

class Producto < ActiveRecord::Base

	# accepts_nested_attributes_for :proveedor

#validations  
  validates :nombre,:cantidad_disponible, :precio_a, :presence => true
  validates :cantidad_disponible, :precio_a, :numericality => { :greater_than_or_equal_to => 0}
  validates :nombre, :length => { :maximum => 100 }
 
#relations
  has_many :item_facturas
  #has_many :lineaKardexes
  has_many :item_proformas
end

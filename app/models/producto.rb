# == Schema Information
#
# Table name: productos
#
#  id                  :integer          not null, primary key
#  nombre              :string(255)      not null
#  precio_compra       :float            not null
#  codigo              :string(255)
#  categoria           :string(255)
#  descripcion         :string(255)
#  fecha_de_caducidad  :date
#  casa_comercial      :string(255)
#  nombre_generico     :string(255)
#  precio_venta        :float
#  cantidad_disponible :float            not null
#

class Producto < ActiveRecord::Base

#callbacks
before_create :set_precios

#validations  
  validates :nombre,:cantidad_disponible, :precio_compra, :presence => true
  validates :cantidad_disponible, :precio_compra, :numericality => { :greater_than_or_equal_to => 0}
  validates :nombre, :length => { :maximum => 100 }
 
#relations
  has_many :item_facturas
  has_one :kardex
  has_many :item_proformas

  #methods
  private
  def set_precios
    precio_compra_iva = self.precio_compra * 0.12 + self.precio_compra
    self.precio_venta = precio_compra_iva * 0.10 + precio_compra_iva
  end
end

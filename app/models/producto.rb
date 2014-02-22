# == Schema Information
#
# Table name: productos
#
#  id              :integer          not null, primary key
#  nombre          :string(255)      not null
#  codigo          :string(255)
#  categoria       :string(255)
#  casa_comercial  :string(255)
#  nombre_generico :string(255)
#

class Producto < ActiveRecord::Base

#validations  
  validates :nombre, :presence => true
  validates :nombre, :length => { :maximum => 100 }
 
#relations
  has_many :ingreso_productos
  has_many :item_facturas
  has_one :kardex
  has_many :item_proformas
  has_many :item_traspasos

#nested
  accepts_nested_attributes_for :ingreso_productos, :allow_destroy => true

#methods

  def cantidad_para_kardex
    unless self.ingreso_productos.empty? then self.ingreso_productos.last.cantidad_disponible else 0 end
  end


end

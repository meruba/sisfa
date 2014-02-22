# == Schema Information
#
# Table name: productos
#
#  id              :integer          not null, primary key
#  nombre          :string(255)      not null
#  codigo          :string(255)
#  categoria       :string(255)
#  descripcion     :string(255)
#  casa_comercial  :string(255)
#  nombre_generico :string(255)
#

class Producto < ActiveRecord::Base

#callbacks
  #before_create :set_precios
  #after_create :set_kardex

#validations  
  validates :nombre, :presence => true
  validates :nombre, :length => { :maximum => 100 }
 
#relations
  has_many :ingreso_productos
  has_many :item_facturas
  has_one :kardex
  has_many :item_proformas
  has_many :item_traspasos

#methods
  private
  def set_precios
    precio_compra_iva = self.precio_compra * 0.12 + self.precio_compra
    self.precio_venta = precio_compra_iva * self.ganancia/100 + precio_compra_iva
  end

  def set_kardex
    Kardex.create(:producto => self, :fecha => Time.now)
  end
end

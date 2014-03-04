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

#callbacks 
  after_create :set_kardex

#validations  
  validates :nombre, :presence => true
  validates :nombre, :length => { :maximum => 100 }
 
#relations
  has_many :ingreso_productos
  has_one :kardex
  has_and_belongs_to_many :factura_compras

#nested
  accepts_nested_attributes_for :ingreso_productos, :allow_destroy => true, reject_if: :all_blank

#methods

  def cantidad_disponible
    unless self.ingreso_productos.empty? then self.ingreso_productos.sum(:cantidad) else 0 end
  end

  private
  def set_kardex
    Kardex.create(:producto => self, :fecha => Time.now)
  end
end

class Producto < ActiveRecord::Base

#validations  
  validates :nombre,:presence => true
  validates :precio,:presence => true,
  					:numericality => { :greater_than_or_equal_to => 0}
  validates :nombre, :length => { :maximum => 100 }
#relations
  has_many :item_facturas
  #has_many :lineaKardexes
  has_many :item_proformas
end

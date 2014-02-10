class Militar < ActiveRecord::Base
  has_many :cliente_militars
  has_many :clientes, through: :cliente_militars
end

# == Schema Information
#
# Table name: militars
#
#  id           :integer          not null, primary key
#  grado        :string(255)
#  codigo_issfa :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  servicio     :string(255)
#

class Militar < ActiveRecord::Base
  has_many :cliente_militars
  has_many :clientes, through: :cliente_militars
end

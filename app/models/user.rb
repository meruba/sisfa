# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  username         :string(255)      not null
#  crypted_password :string(255)
#  salt             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  cliente_id       :integer
#  suspendido       :boolean          default(FALSE)
#

class User < ActiveRecord::Base

authenticates_with_sorcery!


#relationships
	belongs_to :cliente
	has_many :facturas
  has_many :factura_compras
  has_many :traspasos
  has_many :hospitalizacions
  has_one :user_rol
  has_one :rol, through: :user_rol
	accepts_nested_attributes_for :cliente
#validation
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :rol
end

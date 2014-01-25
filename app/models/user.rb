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
#  rol              :string(255)      not null
#  suspendido       :boolean          default(FALSE)
#

class User < ActiveRecord::Base

authenticates_with_sorcery!


#relationships
	belongs_to :cliente
	has_many :facturas
	accepts_nested_attributes_for :cliente
#validation
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username
end

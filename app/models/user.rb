class User < ActiveRecord::Base

authenticates_with_sorcery!


#relationships
	belongs_to :cliente
	
	accepts_nested_attributes_for :cliente
#validation
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username
end

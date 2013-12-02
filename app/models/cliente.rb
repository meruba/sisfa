class Cliente < ActiveRecord::Base

# relationships
	has_one :user
	has_many :proformas
	has_many :facturas
	
end

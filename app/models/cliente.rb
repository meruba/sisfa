class Cliente < ActiveRecord::Base

# relationships
	has_one :user
	
end

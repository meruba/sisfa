class Cliente < ActiveRecord::Base

# relationships
	has_one :user
	has_many :proformas
	has_many :facturas

#method
	def self.search(search)
		if search
			where('numero_de_identificacion LIKE ?', "%#{search}%")
		else
			scoped
		end
	end
end

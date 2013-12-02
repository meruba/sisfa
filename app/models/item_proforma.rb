class ItemProforma < ActiveRecord::Base
#relations
	belongs to :producto

	belongs to :proforma
end

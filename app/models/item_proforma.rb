# == Schema Information
#
# Table name: item_proformas
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class ItemProforma < ActiveRecord::Base
#relations
	belongs to :producto

	belongs to :proforma
end

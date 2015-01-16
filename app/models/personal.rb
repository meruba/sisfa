# == Schema Information
#
# Table name: personals
#
#  id         :integer          not null, primary key
#  cliente_id :integer
#  created_at :datetime
#  updated_at :datetime
#  suspendido :boolean          default(FALSE)
#

class Personal < ActiveRecord::Base
	belongs_to :cliente
	accepts_nested_attributes_for :cliente
end

# == Schema Information
#
# Table name: personals
#
#  id         :integer          not null, primary key
#  cliente_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Personal < ActiveRecord::Base
end

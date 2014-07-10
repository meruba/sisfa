# == Schema Information
#
# Table name: cuartos
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Cuarto < ActiveRecord::Base
	has_many :camas, dependent: :destroy
end

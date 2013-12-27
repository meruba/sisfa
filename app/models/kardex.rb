# == Schema Information
#
# Table name: kardexes
#
#  id          :integer          not null, primary key
#  fecha       :date
#  created_at  :datetime
#  updated_at  :datetime
#  producto_id :integer          not null
#

class Kardex < ActiveRecord::Base
#validations
	validates :fecha, :presence => true
#relations
has_many :lineaKardexes
has_many :productos, :through => :lineaKardexes
end

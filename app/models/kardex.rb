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
  has_many :lineakardexes
  belongs_to :producto

#methods
	def cantidad_salida
		cantidad = self.lineakardexes.where(:tipo => "Salida", :created_at => Time.now.beginning_of_month..Time.now.end_of_month).sum(:cantidad)
	end
end

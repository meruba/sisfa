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
	def lineakardex_mes
		lineas = self.lineakardexes.where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month)
	end

	def cantidad_vendidos
		cantidad = self.lineakardexes.where(:tipo => "Salida").count()
	end
end

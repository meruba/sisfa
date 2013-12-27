# == Schema Information
#
# Table name: lineakardexes
#
#  id         :integer          not null, primary key
#  tipo       :string(255)      not null
#  fecha      :date             not null
#  cantidad   :float            not null
#  v_unitario :float            not null
#  created_at :datetime
#  updated_at :datetime
#  kardex_id  :integer          not null
#

class Lineakardex < ActiveRecord::Base
#validations
	validates :tipo, :fecha, :cantidad, :v_unitario, :presence => true
	validates :cantidad, :v_unitario, :numericality => true, :numericality => { :greater_than_or_equal_to =>0 }
#relations
	belongs_to :producto
	belongs_to :kardex

end

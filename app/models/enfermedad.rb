# == Schema Information
#
# Table name: enfermedads
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  codigo     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Enfermedad < ActiveRecord::Base
end

# == Schema Information
#
# Table name: user_rols
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  rol_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserRol < ActiveRecord::Base
  belongs_to :user
  belongs_to :rol
end

# == Schema Information
#
# Table name: cliente_militars
#
#  id         :integer          not null, primary key
#  relacion   :string(255)
#  cliente_id :integer
#  militar_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class ClienteMilitar < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :militar
end

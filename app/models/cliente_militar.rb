# == Schema Information
#
# Table name: cliente_militars
#
#  id         :integer          not null, primary key
#  cliente_id :integer
#  militar_id :integer
#  relacion   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ClienteMilitar < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :militar
end

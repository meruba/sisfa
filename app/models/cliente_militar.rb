class ClienteMilitar < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :militar
end

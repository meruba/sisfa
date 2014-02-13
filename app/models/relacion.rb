class Relacion < ActiveRecord::Base
	belongs_to :militar
  belongs_to :cliente
end

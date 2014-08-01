class CierreCaja < ActiveRecord::Base
  belongs_to :user
  belongs_to :factura
end

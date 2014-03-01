class Itemfacturacompra < ActiveRecord::Base
  belongs_to :producto
  belongs_to :factura
end

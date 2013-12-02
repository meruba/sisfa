class ItemFactura < ActiveRecord::Base
	  # validations:
    validates :cantidad,  :presence => true,
                          :numericality => { :only_integer => true },
                          :numericality => { :greater_than_or_equal_to => 0 }
    validates :valor_unitario,  :presence => true,
                                :numericality => true,
                                :numericality => { :greater_than_or_equal_to => 0 }
    validates :total, :presence => true,
                            :numericality => true,
                            :numericality => { :greater_than_or_equal_to => 0 }
    validates :descuento, :numericality => true,
                          :numericality => { :greater_than_or_equal_to => 0 }

    #relations
    belongs_to :factura
    belongs_to :producto
    

end

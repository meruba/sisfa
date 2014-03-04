class FacturaComprasController < ApplicationController
  
  def new
    @facturacompra = FacturaCompra.new
  end

end

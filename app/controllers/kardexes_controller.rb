class KardexesController < ApplicationController
  before_filter :find_producto_for_kardex

  def index
    @lineaskardex = @producto.kardex.lineakardexes
  end
end
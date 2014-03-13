class KardexesController < ApplicationController
  before_filter :find_producto_for_kardex
  before_filter :suspendido

  def index
    @lineaskardex = @producto.kardex.lineakardexes
  end
end
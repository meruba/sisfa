class KardexesController < ApplicationController
  before_filter :find_producto_for_kardex

  def index
    @kardex = @producto.kardex
  end
end
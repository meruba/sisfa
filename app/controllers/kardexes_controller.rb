class KardexesController < ApplicationController
	before_action :require_login
  before_filter :is_admin_or_vendedor_farmacia
  before_filter :find_producto_for_kardex

  def index
    @lineaskardex = @producto.kardex.lineakardexes
  end
end

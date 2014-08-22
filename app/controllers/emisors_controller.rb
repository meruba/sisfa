class EmisorsController < ApplicationController
  before_filter :require_login
  before_filter :is_super_user
  before_action :find_emisor, only: [:new]

  def new
    @emisor = Emisor.new
  end

  def edit
    if Emisor.first
      @emisor = Emisor.first
    else
      redirect_to action: "new"
    end
  end

  def show
  end

  def configuracion
    # @emisor = Emisor.new
  end

  def create
    @emisor = Emisor.new(emisor_params)
    if @emisor.save
      redirect_to facturas_path, :notice => "Parámetros configurados correctamente"
    else
      render action: "new"
    end
  end

  def update
    @emisor = Emisor.first
    if @emisor.update(emisor_params)
      redirect_to facturas_path, :notice => "Parámetros configurados correctamente"
    else
      render action: "edit"
    end
  end

  private

  def emisor_params
    params.require(:emisor).permit(:ruc,
      :nombre_establecimiento,
      :numero_inicial_factura,
      :saldo_inicial_inventario)
  end

  def find_emisor
    @created_emisor = Emisor.first
  end
end

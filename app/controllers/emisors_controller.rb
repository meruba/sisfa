class EmisorsController < ApplicationController
  before_filter :require_login
  before_filter :is_super_user, except: [:turnos_otros_dias]
  before_filter :is_admin_or_auxiliar_estadistica, only: [:turnos_otros_dias]
  before_action :find_emisor, only: [:new, :turnos_otros_dias]

  def new
    @emisor = Emisor.new
  end

  def edit
    if Emisor.first
      @emisor = Emisor.first
    else
      redirect_to "new"
    end
  end

  def create
    @emisor = Emisor.new(emisor_params)
    if @emisor.save
      redirect_to facturas_path, :notice => "Parámetros configurados correctamente"
    else
      render "new"
    end
  end

  def update
    @emisor = Emisor.first
    if @emisor.update(emisor_params)
      redirect_to facturas_path, :notice => "Parámetros configurados correctamente"
    else
      render "edit"
    end
  end

  def turnos_otros_dias
    if @created_emisor.otros_dias
      @created_emisor.otros_dias = false
    else
      @created_emisor.otros_dias = true
    end
    @created_emisor.save
    render :text => "#{@created_emisor.otros_dias}"
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

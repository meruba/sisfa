class EmisorsController < ApplicationController
  def new
    @emisor = Emisor.new
  end
  
  def edit
    @emisor = Emisor.first
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
      :numero_inicial_factura)  
  end
end

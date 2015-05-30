class FisiatriaConfiguracionsController < ApplicationController

  before_action :find_config, only: [:edit, :update]

  def new
    @configuracion = FisiatriaConfiguracion.new
  end

  def edit
  end

  def update
    @configuracion.update(configuracion_params)
    respond_to do |format|
      format.json { respond_with_bip(@configuracion) }
    end
  end

  private
  def configuracion_params
    params.require(:fisiatria_configuracion).permit(:numero_turnos,
      :encargado_departamento,
      :grado_director,
      :respuesta_tratamiento
      )
  end

  def find_config
    @configuracion = FisiatriaConfiguracion.last
  end
end

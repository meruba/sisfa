class RegistrosController < ApplicationController
  before_action :find_historia

  def index
    @registros = Registro.all
  end
  
  def new
    @registro = Registro.new
  end

  def create
    @registro = Registro.new(registro_params.merge(:fecha_de_ingreso => Time.now))
    @registro.historia_clinica = @historia
    if @registro.save
      redirect_to historia_clinicas_path
      flash[:notice] = 'Almacenado nuevo registro'
    else
      render "new"
    end
  end

  private

  def registro_params
    params.require(:registro).permit :historia_clinica_id,
      :fecha_de_ingreso,
      :fecha_de_salida,
      :especialidad,
      :medico_asignado,
      :diagnostico_ingreso,
      :diagnostico_salida,
      :discapacidad,
      :dias_hospitalizacion
  end

  def find_historia
    @historia = HistoriaClinica.find(params[:historia_clinica_id])
  end

end

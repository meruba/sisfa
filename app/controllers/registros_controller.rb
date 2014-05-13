class RegistrosController < ApplicationController
  before_action :find_paciente, only: [:new, :create, :edit]
  before_action :set_registro, only: [:edit, :update]

  def index
    @registros = Registro.includes(:paciente).where(:tipo => "Hospitalizacion", :fecha_de_salida => nil).references(:paciente)
  end

  def reporte
    @start_date = params[:fecha_inicial]
    @end_date = params[:fecha_final]
    @registros = Registro.reporte(params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day)
    if @registros.empty?
      render :template => "results/not_result"
    else
      respond_to do |format|
        format.html
        format.xls
      end
    end
  end

  def new
    @registro = Registro.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @registro = Registro.new(registro_params.merge(:fecha_de_ingreso => Time.now))
    @registro.paciente = @paciente
    respond_to do |format|
      @registro.save
      format.js { render "success" }
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    respond_to do |format|
      @registro.update(registro_params)
      format.js { render "salida"}
      format.json { respond_with_bip(@registro) }
    end
  end
  private

  def registro_params
    params.require(:registro).permit :historia_clinica_id,
      :tipo,
      :fecha_de_ingreso,
      :fecha_de_salida,
      :especialidad,
      :medico_asignado,
      :diagnostico_ingreso,
      :diagnostico_salida,
      :discapacidad,
      :dias_hospitalizacion,
      :diagnostico_sec_egreso1,
      :diagnostico_sec_egreso2,
      :condicion_egreso,
      :codigo_cie
  end

  def find_paciente
    @paciente = Paciente.find(params[:paciente_id])
  end

  def set_registro
    @registro = Registro.find(params[:id])
  end
end

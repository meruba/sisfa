class HospitalizacionRegistrosController < ApplicationController
  before_filter :require_login
  before_filter :is_doctor, only: [:edit, :update]
  before_filter :shared_permission, except: [:edit, :update]
  before_action :find_paciente, only: [:new, :create, :edit]
  before_action :set_registro, only: [:edit, :update, :show, :dar_alta_enfermeria]

  def index
    @registros = HospitalizacionRegistro.includes(:paciente => :cliente).where(:fecha_de_ingreso => Time.now.beginning_of_month..Time.now.end_of_month).references(:paciente => :cliente)
  end

  def autocomplete
    respond_to do |format|
      format.json { render :json => HospitalizacionRegistro.autocomplete(params[:term]) }
    end
  end

  def reporte
    @fecha = params[:fecha]
    @registros = HospitalizacionRegistro.reporte(params[:fecha].to_time.beginning_of_month..params[:fecha].to_time.end_of_month)
    if @registros.empty?
      render :template => "results/not_result"
    else
      respond_to do |format|
        format.html
        format.xls
      end
    end
  end
  
  def show
    respond_to do |format|
      format.js
    end
  end

  def new
    @registro = HospitalizacionRegistro.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @registro = HospitalizacionRegistro.new(hospitalizacion_registro_params.merge(:fecha_de_ingreso => Time.now))
    @registro.paciente = @paciente
    respond_to do |format|
      @registro.save
      format.js { render "success" }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      @registro.update(hospitalizacion_registro_params.merge(alta: true))
      format.html { 
        if @registro.save
          redirect_to doctors_dashboard_path, notice: 'Paciente Dado de Alta'
        else
          render action: 'edit'
        end
      }
      format.json { respond_with_bip(@registro) }
    end
  end

  def dar_alta_enfermeria
    unless @registro.alta_enfermeria
      @registro.alta_enfermeria = true
      @registro.save
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def hospitalizacion_registro_params
    params.require(:hospitalizacion_registro).permit :doctor_id,
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
    :codigo_cie,
    :especialidad_egreso,
    :alta
  end

  def find_paciente
    @paciente = Paciente.find(params[:paciente_id])
  end

  def set_registro
    @registro = HospitalizacionRegistro.find(params[:id])
  end
end

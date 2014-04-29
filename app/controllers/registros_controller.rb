class RegistrosController < ApplicationController
  before_action :find_paciente, only: [:new, :create, :edit]
  before_action :set_registro, only: [:edit, :update]

  def index
    @registros = Registro.where(:fecha_de_salida => nil)
  end

  def reporte
    @start_date = params[:fecha_inicial]
    @end_date = params[:fecha_final]
    respond_to do |format|
      format.html{
        Registro.reporte(params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day)
      }
      format.pdf do
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/generar_reporte.html.erb", :orientation => 'Landscape'
      end
      format.js
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
  end

  def update
    respond_to do |format|
      if @registro.update(registro_params)
        format.html { redirect_to pacientes_path, notice: 'Salida Registrada' }
      else
        format.html { render action: 'edit'}
      end
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

  def find_paciente
    @paciente = Paciente.find(params[:paciente_id])
  end

  def set_registro
    @registro = Registro.find(params[:id])
  end
end

class AsignarHorariosController < ApplicationController
include DashboardHospitalHelper
  before_action :find_horario, only: [:edit, :update, :destroy, :dar_alta]
  def autocomplete
    respond_to do |format|
      format.json { render :json => AsignarHorario.autocomplete(params[:term]) }
    end
  end

  def reporte_ingresados
  	@fecha = params[:fecha]
  	@ingresados = AsignarHorario.reporte_mensual(@fecha)
    @total = @ingresados.sum(:total_factura)
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "reporte de terapista", :layout => 'report.html', :template => "asignar_horarios/reporte_ingresados.pdf.erb", :orientation => 'Landscape'
      end
    end
  end

	def new
		@horario = AsignarHorario.new
		@horario.tratamiento_registros.build
		@horario.resultado_tratamientos.build
		@tratamientos =  ItemTratamiento.where(:suspendido => false)
		respond_to do |format|
	    format.js
	  end
	end

  def view_edit
    @registros = AsignarHorario.includes(paciente: [:cliente], tratamiento_registros: [:item_tratamiento]).last(10)
  end

  def dar_alta
    if @horario.alta
      @horario.alta = false
    else
      @horario.alta = true
    end
    @horario.save
    respond_to do |format|
      format.js
    end
  end

  def edit
    @tratamientos =  ItemTratamiento.where(:suspendido => false)
    respond_to do |format|
      format.js{ render "new" }
    end
  end

  def update
    respond_to do |format|
      @horario.update(horario_params)
      format.js
    end
  end

	def create
		@horario = AsignarHorario.new(horario_params)
		@horario.save
		respond_to do |format|
	    format.js{
	    	@numero_dias = numero_dias(Time.now)
  			@espacios = number_space(Time.now)
  			@fecha = Time.now
	    	@turnos = DisponiblidadHorario.where(:dia => Time.now.beginning_of_month..Time.now.end_of_month)
	    }
	  end
	end

  def destroy
    @horario.destroy
    respond_to do |format|
      format.js
    end
  end

	private

	def horario_params
		params.require(:asignar_horario).permit(:paciente_id,
			:numero_factura,
      :total_factura,
      :fecha_inicio,
      :horario_id,
			:numero_terapias,
			:doctor_remitente,
			:diagnostico,
      :id,
			:tratamiento_registros_attributes => [
				:nombre_tratamiento,
				:item_tratamiento_id,
        :asignar_horario_id,
        :id,
				:_destroy
			],
			:resultado_tratamientos_attributes => [
				:fecha,
				:horario_id,
				:paciente_id,
        :asignar_horario_id,
        :id,
				:_destroy
			]
			)
	end

  def find_horario
    @horario =  AsignarHorario.find(params[:id])
  end
end

class AsignarHorariosController < ApplicationController
include DashboardHospitalHelper
  before_action :find_horario, only: [:edit, :update, :destroy]
  def autocomplete
    respond_to do |format|
      format.json { render :json => AsignarHorario.autocomplete(params[:term]) }
    end
  end

  def reporte_ingresados
  	@fecha = params[:fecha]
  	@ingresados = AsignarHorario.reporte_mensual(@fecha)
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
    # turnos = Turno.includes(paciente: [:cliente]).where(:fecha => Time.now.beginning_of_day..Time.now.end_of_day).references(paciente: [:cliente])
    # @paciente = Paciente.includes(:cliente, :informacion_adicional_paciente, :condicions).where(:id => params[:paciente_id]).references(:cliente, :informacion_adicional_paciente, :condicions).first

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

	private

	def horario_params
		params.require(:asignar_horario).permit(:paciente_id,
			:numero_factura,
			:total_factura,
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

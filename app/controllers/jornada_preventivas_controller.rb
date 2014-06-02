class JornadaPreventivasController < ApplicationController
	before_action :find_doctor, only: [:index, :new, :create, :edit, :update]
	
	def index
		@jornadas = @doctor.jornada_preventivas
	end

	def new
		@enviado = @doctor.jornada_preventivas.was_send
		if @enviado == false
			@jornada = JornadaPreventiva.new
			@consultas = @doctor.consulta_externa_preventivas.today
		else
			render :template => "results/was_send"
		end
	end

	def create
		@jornada = JornadaPreventiva.new(jornada_preventiva_params)
		@jornada.doctor = @doctor
		if @jornada.save
			redirect_to doctors_dashboard_path, :notice => "Reporte enviado"
		else
			redirect_to doctors_dashboard_path
		end
	end

	def reporte
		@registros = JornadaPreventiva.reporte(params[:fecha].to_time.beginning_of_day..params[:fecha].to_time.end_of_day)
		respond_to do |format|
			format.html
			format.xls
		end
	end

	private
	def jornada_preventiva_params
		params.require(:jornada_preventiva).permit :doctor_id,
		:inicio_atencion,
		:fin_atencion,
		:horas_trabajadas
	end

	def find_doctor
		@doctor = Doctor.find(params[:doctor_id])
	end
end

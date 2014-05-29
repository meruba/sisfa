class JornadaMorbilidadsController < ApplicationController
	before_action :find_doctor, only: [:index, :new, :create, :edit, :update]
	
	def index
		@jornadas = @doctor.jornada_morbilidads
	end

	def new
		@enviado = @doctor.jornada_morbilidads.was_send
		if @enviado == false
			@jornada = JornadaMorbilidad.new
			@consultas = @doctor.consulta_externa_morbilidads.today
		else
			render :template => "results/was_send"
		end
	end

	def create
		@jornada = JornadaMorbilidad.new(jornada_morbilidad_params)
		@jornada.doctor = @doctor
		if @jornada.save
			redirect_to doctors_dashboard_path, :notice => "Almacenado"
		else
			redirect_to doctors_dashboard_path
		end
	end
	
	private
	def jornada_morbilidad_params
		params.require(:jornada_morbilidad).permit :doctor_id,
		:inicio_atencion,
		:fin_atencion,
		:horas_trabajadas
	end

	def find_doctor
		@doctor = Doctor.find(params[:doctor_id])
	end
end

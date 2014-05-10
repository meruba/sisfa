class TurnosController < ApplicationController
	
	before_action :set_turno, only: [:atendido, :siguiente_dia]

	def index
		@doctores = Doctor.turnos_doctores
		# raise
	end

	def admin_turnos
		@no_atendidos = Turno.where(:atendido => false)
		@atendidos = Turno.where(:atendido => true)		
	end

	def new
		@turno = Turno.new
		respond_to do |format|
			format.html
			format.js
		end
	end

	def create
		@turno = Turno.new(turno_params)
		respond_to do |format|
			@turno.save
			format.js { render "success" }
		end
	end

	def atendido
		unless @turno.atendido
			@turno.atendido = true
		else
			@turno.atendido = false
		end
		@turno.save
		# render :text => "cambio"
		redirect_to doctors_control_turno_path, :notice => "Almacenado"
	end

	def siguiente_dia
		@nuevo_turno = Turno.new
		@nuevo_turno.paciente_id = @turno.paciente_id
		@nuevo_turno.doctor_id = @turno.doctor_id
		@nuevo_turno.doctor_a_cargo = @turno.doctor_a_cargo
		@nuevo_turno.hora = @turno.hora
		@nuevo_turno.save
		redirect_to doctors_path, :notice => "Almacenado"
	end

	private

	def turno_params
		params.require(:turno).permit :fecha,
		:hora,
		:doctor_a_cargo,
		:numero,
		:atendido,
		:paciente_id,
		:doctor_id
	end

	def set_turno
		@turno = Turno.find(params[:id])
	end
end

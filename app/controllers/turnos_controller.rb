class TurnosController < ApplicationController
	
	before_action :set_turno, only: [:atendido, :siguiente_dia]

	def index
		@doctores = Doctor.turnos_doctores
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

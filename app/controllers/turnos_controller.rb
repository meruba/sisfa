class TurnosController < ApplicationController
	def index
		@turnos = Turno.all
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
			@registro.save
			format.js { render "success" }
		end
	end

	def atendido
		
	end

	private

	def turno_params
		params.require(:turno).permit :fecha,
		:hora,
		:doctor,
		:atendido,
		:paciente_id	
	end
end

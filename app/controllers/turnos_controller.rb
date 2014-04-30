class TurnosController < ApplicationController
	def index
		
	end

	def new
		@turno = Turno.new
	end

	def create
		@turno = Turno.new(turno_params)
		if @turno.save
			redirect_to pacientes_path, :notice => "Almacenado"
		else
			render action: 'new'
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

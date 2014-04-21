class PacientesController < ApplicationController

	def index
		@all = Paciente.all
	end

	def show
	end

	def new
		@paciente= Paciente.new
		@paciente.build_cliente
	end

	def militar
		@paciente= Paciente.new(:tipo => "militar")
		@paciente.build_cliente
	end

	def familiar
		@paciente= Paciente.new(:tipo => "familiar")
		@paciente.build_cliente
	end

	def civil
		@paciente= Paciente.new(:tipo => "civil")
		@paciente.build_cliente
	end

	def create
		@paciente = Paciente.new(paciente_params)
		@paciente.save
	end

	def update
		respond_to do |format|
			@paciente.update(cliente_params)
			format.js { render "success"}
		end
	end

	private

	def paciente_params
		params.require(:paciente).permit :tipo,
			:grado,
			:estado,
			:codigo_issfa,
			:pertenece_a,
			:unidad,
			:parentesco,
			:cliente_attributes => [
				:id,
				:nombre,
				:direccion,
				:telefono,
				:numero_de_identificacion,
				:sexo,
				:edad,
				:estado_civil
			]		
	end
end

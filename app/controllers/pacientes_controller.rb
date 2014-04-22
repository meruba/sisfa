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
		@paciente.build_informacion_adicional_paciente
	end

	def familiar
		@paciente= Paciente.new(:tipo => "familiar")
		@paciente.build_cliente
		@paciente.build_informacion_adicional_paciente

	end

	def civil
		@paciente= Paciente.new(:tipo => "civil")
		@paciente.build_cliente
		@paciente.build_informacion_adicional_paciente
	end

	def create
		@paciente = Paciente.new(paciente_params)
		if @paciente.save
			redirect_to clientes_path, :notice => "Almacenado"
		else
			render action: 'new'
		end
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
			],
			:informacion_adicional_paciente_attributes => [
				:ciudad,
				:provincia,
				:canton,
				:jefe_de_reparto,
				:familiar_cercano,
				:familiar_direccion,
				:familiar_telefono,
				:observacion,
				:paciente_id
			]
	end
end

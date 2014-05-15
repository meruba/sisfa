class PacientesController < ApplicationController
	before_action :set_paciente, only: [:edit, :update]
	before_action :new_paciente, only: [:civil, :militar, :familiar]

	def index
		respond_to do |format|
      format.html
      format.json { render json: PacientesDatatable.new(view_context) }
    end
	end

	def autocomplete
    respond_to do |format|
      format.json { render :json => Paciente.autocomplete(params[:term]) }
    end
  end

	def civil
		@paciente.tipo = "civil"
	end
		
	def militar
		@paciente.tipo = "militar"
	end

	def familiar
		@paciente.tipo = "familiar"
	end

	def show
		@paciente = Paciente.includes(:cliente, :informacion_adicional_paciente).where(:id => params[:id]).references(:cliente, :informacion_adicional_paciente).first
	end
	
	def create
		@paciente = Paciente.new(paciente_params)
		if @paciente.save
			redirect_to pacientes_path, :notice => "Almacenado"
		else
			render action: 'new'
		end
	end
	
	def edit
	end

	def update
		respond_to do |format|
			@paciente.update(paciente_params)
			format.json { respond_with_bip(@paciente) }
		end
	end

	private

	def paciente_params
		params.require(:paciente).permit :tipo,
			:n_hclinica,
			:grado,
			:estado,
			:codigo_issfa,
			:pertenece_a,
			:unidad,
			:parentesco,
			:cliente_attributes => [
				:id,
				:fecha_de_nacimiento,
				:nombre,
				:direccion,
				:telefono,
				:numero_de_identificacion,
				:sexo,
				:edad,
				:estado_civil
			],
			:informacion_adicional_paciente_attributes => [
				:parroquia,
				:provincia,
				:canton,
				:raza,
				:nacionalidad,
				:jefe_de_reparto,
				:familiar_parentesco,
				:familiar_cercano,
				:familiar_direccion,
				:familiar_telefono,
				:observacion,
				:paciente_id
			]
	end

	def set_paciente
		@paciente = Paciente.find(params[:id])
	end

	def new_paciente
		@paciente= Paciente.new
		# @paciente.registros.build
		@paciente.build_cliente
		@paciente.build_informacion_adicional_paciente
	end
end

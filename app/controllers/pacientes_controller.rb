class PacientesController < ApplicationController
  before_filter :require_login
  before_filter :is_admin_or_auxiliar_estadistica, :except => [:show, :view_edit, :edit, :update]
  before_filter :shared_permission, :only => [:show, :view_edit, :edit, :update]
	before_action :set_paciente, only: [:edit, :update, :destroy]
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
		@paciente.afiliado = "ISSFA"
	end

	def familiar
		@paciente.tipo = "familiar"
		@paciente.afiliado = "ISSFA"
	end

	def view_edit
		@paciente = Paciente.includes(:cliente, :informacion_adicional_paciente).where(:id => params[:paciente_id]).references(:cliente, :informacion_adicional_paciente).first
	end
	
	def print_historia
		@paciente = Paciente.includes(:cliente, :informacion_adicional_paciente, :condicions).where(:id => params[:paciente_id]).references(:cliente, :informacion_adicional_paciente, :condicions).first
		respond_to do |format|
			format.pdf do
				render :pdf => "historia", :layout => 'report.html', :template => "pacientes/print_historia.pdf.erb"
			end
		end
	end

	def show
		@paciente = Paciente.includes(:cliente, :informacion_adicional_paciente).where(:id => params[:id]).references(:cliente, :informacion_adicional_paciente).first
		@registros = Paciente.medical_records(@paciente)
	end
	
	def create
		@paciente = Paciente.new(paciente_params)
		if @paciente.save
			redirect_to pacientes_path, :notice => "Almacenado"
		else
			case @paciente.tipo
			when "civil"
				render action: 'civil'
			when "familiar"
				render action: 'familiar'
			when "militar"				
				render action: 'militar'
			end
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

	def destroy
		@paciente.destroy
		respond_to do |format|
			format.html { redirect_to pacientes_url }
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
		:jefe_de_reparto,
		:afiliado,
		:discapacidad,
		:antecedentes_personales,
		:antecedentes_familiares,
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
			@paciente.build_cliente
			@paciente.build_informacion_adicional_paciente
		end
end

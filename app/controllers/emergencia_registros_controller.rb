class EmergenciaRegistrosController < ApplicationController
	before_action :find_paciente, only: [:new, :create, :edit, :show, :update]
	before_action :set_emergencia, only: [:edit, :update, :show]

	def index
		@emergencia = EmergenciaRegistro.all
	end

	def new
		@emergencia = EmergenciaRegistro.new
		respond_to do |format|
			format.html
			format.js
		end
	end

	def create
    @emergencia = EmergenciaRegistro.new(emergencia_registro_params.merge(registrado: false))
		@emergencia.paciente = @paciente
		respond_to do |format|
			@emergencia.save
			format.js { render "success" }
		end
	end
	
	def show
	
	end

	def edit
		@emergencia.build_condicion
		respond_to do |format|
			format.html
			format.js
		end
	end

	def update
		respond_to do |format|
			if @emergencia.update(emergencia_registro_params.merge(registrado: true))
        format.html { redirect_to doctors_dashboard_path, notice: 'Emergencia Almacenada' }
      else
        format.html { render action: 'edit' }
			end
		end
	end
	private

	def emergencia_registro_params
		params.require(:emergencia_registro).permit :paciente_id,
		:doctor_id,
		:nombre_medico,
		:especialidad,
		:tipo_usuario,
		:atencion,
		:destino,
		:causa,
		:diagnostico,
		:condicion_salir,
		:grupos_etareos,
		:condicion_attributes => [
			:paciente_id,
			:doctor_id,
			:motivo_de_consulta,
			:medico_asignado,
			:antecedentes_personales,
			:antecedentes_familiares,
			:enfermedad_actual,
			:revision_organos_sistema,
			:presion_arterial,
			:pulso,
			:temperatura,
			:examen_fisico,
			:diagnostico_1,
			:diagnostico_2,
			:planes
		]
	end

	def find_paciente
		@paciente = Paciente.find(params[:paciente_id])
	end

	def set_emergencia
		@emergencia = EmergenciaRegistro.find(params[:id])
	end
end

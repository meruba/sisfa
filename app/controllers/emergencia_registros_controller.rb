class EmergenciaRegistrosController < ApplicationController
	before_filter :require_login
  before_filter :is_doctor, only: [:edit, :update]
  before_filter :shared_permission, except: [:edit, :update]
	before_action :find_paciente, only: [:new, :create, :edit, :show, :update]
	before_action :set_emergencia, only: [:edit, :update, :show]

	def new
		@registro = EmergenciaRegistro.new
		respond_to do |format|
			format.html
			format.js
		end
	end

	def create
    @registro = EmergenciaRegistro.new(emergencia_registro_params.merge(registrado: false))
		@registro.paciente = @paciente
		respond_to do |format|
			@registro.save
			format.js { render "success" }
		end
	end
	
	def show
	
	end

	def edit
		@registro.build_condicion
		respond_to do |format|
			format.html
			format.js
		end
	end

	def update
		respond_to do |format|
			if @registro.update(emergencia_registro_params.merge(registrado: true))
        format.html { redirect_to doctors_dashboard_path, notice: 'Emergencia Almacenada' }
      else
        format.html { render 'edit' }
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
		@registro = EmergenciaRegistro.find(params[:id])
	end
end

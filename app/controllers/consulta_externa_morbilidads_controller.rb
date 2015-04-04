class ConsultaExternaMorbilidadsController < ApplicationController
	before_action :require_login
	before_filter :is_doctor
	before_action :find_turno, only: [:new, :create, :edit, :update]
	before_action :set_consulta, only: [:edit, :update, :show]

	def new
		@consulta = ConsultaExternaMorbilidad.new
		@consulta.build_condicion
	end

	def create
		@consulta = ConsultaExternaMorbilidad.new(consulta_registro_params)
		@consulta.doctor = @turno.doctor
		@consulta.nombre_medico = @turno.doctor.cliente.nombre
		@consulta.paciente = @turno.paciente
		@consulta.turno = @turno
		if @consulta.save
			if params[:enviar_fisiatria] == "1"
				n = NecesitaTerapia.new(paciente: @turno.paciente, consulta_externa_morbilidad: @consulta)
				n.save
			end
			redirect_to doctors_dashboard_path, :notice => "Almacenado"
		else
			render 'new'
		end
	end

	def show

	end

	def edit
	end

	def update
		respond_to do |format|
			if @consulta.update(consulta_registro_params.merge(registrado: true))
        format.html { redirect_to doctors_path, notice: 'Registro Almacenado' }
      else
        format.html { render 'edit' }
			end
		end
	end

	private

	def consulta_registro_params
		params.require(:consulta_externa_morbilidad).permit :paciente_id,
		:doctor_id,
		:turno_id,
		:condicion_id,
		:nombre_medico,
		:tipo_de_atencion,
		:grupos_de_edad,
		:diagnostico_sindrome,
		:codigo_cie,
		:condicion_diagnostico,
		:ordenes,
		:certificado_medico,
		:inicio_atencion,
		:fin_atencion,
		:horas_trabajadas,
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

	def find_turno
		@turno = Turno.find(params[:turno_id])
	end

	def set_consulta
		@consulta = ConsultaExternaMorbilidad.find(params[:id])
	end
end

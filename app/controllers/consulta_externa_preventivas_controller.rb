class ConsultaExternaPreventivasController < ApplicationController
	before_action :find_turno, only: [:new, :create, :edit, :show, :update]
	before_action :set_consulta, only: [:edit, :update, :show]

	def new
		@consulta = ConsultaExternaPreventiva.new
		@consulta.build_condicion
	end

	def create
		@consulta = ConsultaExternaPreventiva.new(consulta_registro_params)
		@consulta.doctor = @turno.doctor
		@consulta.nombre_medico = @turno.doctor.cliente.nombre
		@consulta.paciente = @turno.paciente
		@consulta.turno = @turno
		# raise
		if @consulta.save
			redirect_to doctors_dashboard_path, :notice => "Almacenado"
		else
			redirect_to doctors_dashboard_path
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
		params.require(:consulta_externa_preventiva).permit :paciente_id,
		:doctor_id,
		:turno_id,
		:condicion_id,
		:nombre_medico,
		:tipo_de_atencion,
		:atencion_preventiva,
		:grupos_de_edad,
		:prenatal,
		:partos,
		:post_partos,
		:planificacion_familiar,
		:doc,
		:certificado_medico,
		:trabajadora_sexual,
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
		@consulta = ConsultaExternaPreventiva.find(params[:id])
	end
end

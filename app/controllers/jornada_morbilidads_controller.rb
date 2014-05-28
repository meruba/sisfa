class JornadaMorbilidadsController < ApplicationController
	before_action :find_doctor, only: [:new, :create, :edit, :update]

	def new
		@jornada = JornadaMorbilidad.new		
		@consultas = @doctor.consulta_externa_morbilidads
		# raise
	end

	def create
		@jornada = JornadaMorbilidad.new(jornada_morbilidad_params)
		@jornada.doctor = @doctor
		if @jornada.save
			redirect_to doctors_dashboard_path, :notice => "Almacenado"
		else
			redirect_to doctors_dashboard_path
		end
	end
	
	private
	def jornada_morbilidad_params
		params.require(:jornada_morbilidad).permit :doctor_id,
		:inicio_atencion,
		:fin_atencion,
		:horas_trabajadas,
		:total_hombre,
		:total_mujer,
		:total_blanco,
		:total_mestizo,
		:total_afroecuatoriano,
		:total_indigena,
		:total_montubio,
		:total_colombiano,
		:total_peruano,
		:total_otra_nacionalidad,
		:total_iess,
		:total_issfa,
		:total_ispol,
		:total_otros_seguros,
		:total_aerea,
		:total_naval,
		:total_terrestre,
		:total_activo,
		:total_pasivo,
		:total_aspirante,
		:total_conscripto,
		:total_activo_familiar,
		:total_pasivo_familiar,
		:total_derecho_hab,
		:total_civilies,
		:total_atencion_primera,
		:total_atencion_subsecuente,
		:total_atencion_interconsulta,
		:total_memor_1_mes,
		:total_memor_1_11_mes,
		:total_1_4_anios,
		:total_5_9_anios,
		:total_10_44_anios,
		:total_15_19_anios,
		:total_20_49_anios,
		:total_50_64_anios,
		:total_65_anios,
		:total_presuntivo,
		:total_inicial,
		:total_control,
		:total_interconsulta,
		:total_referencia,
		:total_certificado_medico
	end

	def find_doctor
		@doctor = Doctor.find(params[:doctor_id])
	end
end

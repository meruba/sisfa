class HistoriaClinicasController < ApplicationController
	
	def new
		@historia = HistoriaClinica.new
		@historia.registros.build
    @historia.build_paciente
    @historia.paciente.build_cliente
		@historia.paciente.build_informacion_adicional_paciente
	end

	def create	
		@historia = HistoriaClinica.new(historia_clinica_params.merge(fecha: Time.now))
		if @historia.save
			redirect_to clientes_path, :notice => "Historia Clinica Almacenada"
		else
			render action: 'new'
		end
	end

	private
	def historia_clinica_params
		params.require(:historia_clinica).permit :numero,
		:fecha,
		:paciente_id,
		:paciente_attributes => [
			:tipo,
			:grado,
			:estado,
			:codigo_issfa,
			:pertenece_a,
			:unidad,
			:parentesco,
			:cliente_id,
			:cliente_attributes => [
				:id,
				:nombre,
				:direccion,
				:telefono,
				:numero_de_identificacion,
				:sexo,
				:edad,
				:estado_civil,
				:fecha_de_nacimiento
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
		],
		:registros_attributes => [
			:especialidad,
			:medico_asignado
		]
	end
end

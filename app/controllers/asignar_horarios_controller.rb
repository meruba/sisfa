class AsignarHorariosController < ApplicationController

	def new
		@horario = AsignarHorario.new
		@horario.tratamiento_registros.build
		@horario.resultado_tratamientos.build
		respond_to do |format|
	    format.js
	  end
	end

	def create
		@horario = AsignarHorario.new(horario_params)
		@horario.save
		respond_to do |format|
	    format.js
	  end
	end

	def edit

	end

	def update

	end

	private

	def horario_params
		params.require(:asignar_horario).permit(:paciente_id,
			:numero_factura,
			:total_factura,
			:diagnostico,
			:tratamiento_registros_attributes => [
				:nombre_tratamiento,
				:asignar_horario_id,
				:item_tratamiento_id,
				:_destroy
			],
			:resultado_tratamientos_attributes => [
				:fecha,
				:horario_id,
				:_destroy
			]
			)
	end
end

class InformacionAdicionalPacientesController < ApplicationController

	def update
		@informacion = InformacionAdicionalPaciente.find(params[:id])
		respond_to do |format|
			@informacion.update(informacion_params)
			format.json { respond_with_bip(@informacion) }
			format.js
		end
	end

	private
	def informacion_params
		params.require(:informacion_adicional_paciente).permit :ciudad,
		:provincia,
		:canton,
		:jefe_de_reparto,
		:familiar_cercano,
		:familiar_direccion,
		:familiar_telefono,
		:observacion,
		:paciente_id
	end
end

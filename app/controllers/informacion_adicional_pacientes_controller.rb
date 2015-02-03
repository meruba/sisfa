class InformacionAdicionalPacientesController < ApplicationController
  before_filter :require_login
  before_filter :shared_permission

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
		params.require(:informacion_adicional_paciente).permit :parroquia,
		:provincia,
		:canton,
		:nacionalidad,
		:raza,
		:jefe_de_reparto,
		:familiar_cercano,
		:familiar_parentesco,
		:familiar_direccion,
		:familiar_telefono,
		:observacion,
		:paciente_id,
		:representante_legal
	end
end

class ItemSignoVitalsController < ApplicationController
	before_filter :require_login
  before_filter :is_admin_or_enfermera_enfermeria
  
	def create
		@signo = ItemSignoVital.new(item_signo_vital_params.merge(fecha: Time.now, user_id: current_user.id))
		@signo.save
		respond_to do |format|
			format.js
		end
	end

	private

	def item_signo_vital_params
		params.require(:item_signo_vital).permit :signo_vital_id,
		:hora,
		:temperatura,
		:pulso,
		:respiracion,
		:tension_arterial,
		:observacion
	end
end

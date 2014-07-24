class SignoVitalsController < ApplicationController
	before_action :find_signo, only: [:show]
	
	def show
		@registro = ItemSignoVital.new
		@signos = @hoja_signos.item_signo_vitals
	end
	
	private

	def find_signo
		@hoja_signos = SignoVital.find_by_hospitalizacion_registro_id(params[:id])
	end
end

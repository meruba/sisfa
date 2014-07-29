class EmergenciaParteMensualsController < ApplicationController
	before_filter :require_login
  before_filter :is_admin_or_auxiliar_estadistica
	def reporte
		@registros = EmergenciaParteMensual.reporte(params[:fecha].to_time.beginning_of_month..params[:fecha].to_time.end_of_month)
		respond_to do |format|
			format.html
			format.xls
		end
	end
end

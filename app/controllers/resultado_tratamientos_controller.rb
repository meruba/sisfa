class ResultadoTratamientosController < ApplicationController
	def by_day
		fecha = params[:dia].to_date
		@turnos = ResultadoTratamiento.where(:fecha => fecha.beginning_of_day..fecha.end_of_day)
	end
end

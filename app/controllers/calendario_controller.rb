class CalendarioController < ApplicationController
	include DashboardHospitalHelper
	def index
  	# calendario
  	@numero_dias = numero_dias(Time.now)
  	@espacios = number_space(Time.now)
  end
end

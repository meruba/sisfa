class CalendarioController < ApplicationController
	include DashboardHospitalHelper
	def index
  	# calendario
  	@numero_dias = numero_dias(Time.now)
  	@espacios = number_space(Time.now)
  	@fecha = Time.now
  	@turnos = DisponiblidadHorario.where(:dia => Time.now.beginning_of_month..Time.now.end_of_month)
  end

  def next_month
  	@numero_dias = numero_dias(Time.now + 1.month)
  	@espacios = number_space(Time.now + 1.month)
  	@fecha = Time.now + 1.month
  	@turnos = DisponiblidadHorario.where(:dia => @fecha.beginning_of_month..@fecha.end_of_month)
  	respond_to do |format|
  		format.js
  	end
  end

  def prev_month
  	@numero_dias = numero_dias(Time.now - 1.month)
  	@espacios = number_space(Time.now - 1.month)
  	@fecha = Time.now - 1.month
  	@turnos = DisponiblidadHorario.where(:dia => @fecha.beginning_of_month..@fecha.end_of_month)
  	respond_to do |format|
			format.js
		end
  end

  def current_month
  	index
  	respond_to do |format|
  		format.js
  	end
  end
end

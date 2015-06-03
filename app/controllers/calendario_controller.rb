class CalendarioController < ApplicationController
  before_filter :require_login
  before_filter :is_admin_or_fisiatra_fisiatria

	include DashboardHospitalHelper

	def index
  	# calendario
  	@numero_dias = numero_dias(Time.now)
  	@espacios = number_space(Time.now)
  	@fecha = Time.now
  	@turnos = DisponiblidadHorario.where(:dia => Time.now.beginning_of_month..Time.now.end_of_month)
  end

  def next_month
    current_date = params[:fecha].to_time
  	@numero_dias = numero_dias(current_date + 1.month)
  	@espacios = number_space(current_date + 1.month)
    @fecha = current_date + 1.month
  	@turnos = DisponiblidadHorario.where(:dia => @fecha.beginning_of_month..@fecha.end_of_month)
  	respond_to do |format|
  		format.js
  	end
  end

  def prev_month
    current_date = params[:fecha].to_time
  	@numero_dias = numero_dias(current_date - 1.month)
  	@espacios = number_space(current_date - 1.month)
  	@fecha = current_date- 1.month
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

class TurnosController < ApplicationController
	before_filter :require_login
	before_filter :is_admin_or_auxiliar_estadistica
	before_action :set_turno, only: [:atendido, :siguiente_dia, :edit, :update, :destroy]

	def index
		@doctores = Doctor.turnos_doctores
	end

	def hoy
		respond_to do |format|
			@turnos = Doctor.list_turnos_query(Time.now.beginning_of_day..Time.now.end_of_day)
			@fecha =  Time.now
			format.html
			format.pdf do
				render :pdf => "turnos de hoy", :layout => 'report.html', :template => "turnos/print_turnos.html.erb"
			end
		end
	end

	def manana
		@turnos = Doctor.list_turnos_query(Time.now.tomorrow.beginning_of_day..3.days.from_now.end_of_day)
		@fecha =  Time.now.tomorrow
		respond_to do |format|
			format.html
			format.pdf do
				render :pdf => "turnos de manana", :layout => 'report.html', :template => "turnos/print_turnos.html.erb"
			end
		end
	end

	def new
		@turno = Turno.new
		respond_to do |format|
			format.js
		end
	end

	def create
		@turno = Turno.new(turno_params)
		if @_params[:hoy] == "1" #obtiene valor del check_box_tag
			@turno.fecha = Time.now.beginning_of_day
		else
			if Time.now.wday == 5 #is friday?
				@turno.fecha = 3.days.from_now.beginning_of_day #fecha del viernes al lunes
			else
			@turno.fecha = Time.now.tomorrow.beginning_of_day #fecha para el proximo dia
			end
		end
		respond_to do |format|
			@turno.save
			format.js {
				@doctores = Doctor.turnos_doctores
				render "success"
			}
		end
	end

	def edit
		respond_to do |format|
			format.js
		end
	end

	def update
		respond_to do |format|
			@turno.update(turno_params)
			format.js {
				@turnos = Doctor.turnos_doctores
				render "change"
			}
		end
	end

	def destroy
		@turno.destroy
		respond_to do |format|
			format.html { redirect_to turnos_url }
		end
	end
	
	private

	def turno_params
		params.require(:turno).permit :fecha,
		:hora,
		:doctor_a_cargo,
		:numero,
		:atendido,
		:paciente_id,
		:doctor_id
	end

	def set_turno
		@turno = Turno.find(params[:id])
	end
end

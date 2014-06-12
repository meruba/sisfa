class TurnosController < ApplicationController
	
	before_action :set_turno, only: [:atendido, :siguiente_dia, :edit, :update, :destroy]

	def index
		@doctores = Doctor.turnos_doctores
	end

	def hoy
		@turnos = Doctor.list_turnos_query(Time.now.beginning_of_day..Time.now.end_of_day)
	end

	def manana
		@turnos = Doctor.list_turnos_query(Time.now.tomorrow.beginning_of_day..Time.now.tomorrow.end_of_day)	
	end

	def new
		@turno = Turno.new
		respond_to do |format|
      format.js
		end
	end

	def create
		@turno = Turno.new(turno_params)
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

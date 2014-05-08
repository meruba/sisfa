class DoctorsController < ApplicationController
	before_filter :require_login
	before_filter :suspendido
	# before_action :set_doctor, only: [:show, :edit, :update, :destroy]

	def index
		@doctores = Doctor.all
		@doctor = Doctor.new
	end

	def show
	end

	def new
		@doctor = Doctor.new
	end

	def control_turno
		@doctores = Doctor.all
	end

	def turnos_dia
		@turnos = Turno.turnos_today
	end

  def autocomplete
    respond_to do |format|
      format.json { render :json => Doctor.autocomplete(params[:term]) }
    end
  end

	def edit
	end

	def create
		@doctor = Doctor.new(doctor_params)
		if @doctor.save
			redirect_to doctors_path, :notice => "Almacenado"
		else
			render action: 'new'
		end
	end

	def update
		@doctor.update(doctor_params)
		@doctor.save
		redirect_to doctors_path
	end

	def destroy
		@doctor.destroy
		respond_to do |format|
			format.html { redirect_to doctors_url }
		end
	end

	private

	def set_doctor
		@doctor = Doctor.find(params[:id])
	end

	def doctor_params
		params.require(:doctor).permit(:nombre, :especialidad)
	end
end

class PersonalsController < ApplicationController
	before_action :find_personal, only: [:suspender]
	
	def index
		@personals = Personal.all
	end

	def new 
		@personal = Personal.new #CREA UN OBJETO personal 
		@personal.build_cliente #permite crear itemtratamientos
	end
	def create
		@personal = Personal.new(personal_params)
		if @personal.save
			redirect_to new_personal_path, :notice => "GUARDADO"
		else
			raise
			redirect_to new_personal_path, :notice => "NO GUARDADO"	
		end	
	end
	def edit

	end
	def update

	end
	def suspender
   if @personal.suspendido
      @personal.suspendido = false
    else
      @personal.suspendido = true
    end
    @personal.save
    redirect_to personals_path, :notice => "Terapista modificado"
	end	
	
	private 

	def personal_params
		params.require(:personal).permit(:cliente_id,
			:cliente_attributes=>[ :direccion, :nombre, :numero_de_identificacion, :telefono, :_destroy]
			)	
	end

	def find_personal
			@personal = Personal.find(params[:id])
	end	
end

class PersonalsController < ApplicationController
	
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

	end	
	
	private 

	def personal_params
		params.require(:personal).permit(:cliente_id,
			:cliente_attributes=>[ :direccion, :nombre, :numero_de_identificacion, :telefono, :_destroy]
			)	
	end	
end

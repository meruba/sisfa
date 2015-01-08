class TratamientosController < ApplicationController
	def index
		
	end
	def new 
		@tratamiento = Tratamiento.new #CREA UN OBJETO TIPO TRATAMIENTO 
	end
	def create
		@tratamiento = Tratamiento.new(tratamiento_params)
		if @tratamiento.save
			redirect_to new_tratamiento_path, :notice => "GUARDADO"
		else
			redirect_to new_tratamiento_path, :notice => "NO GUARDADO"	
		end	
	end
	def edit

	end
	def update

	end
	def anular

	end	
	
	private

	def tratamiento_params
		params.require(:tratamiento).permit(:nombre, :numeracion)	
	end	
end

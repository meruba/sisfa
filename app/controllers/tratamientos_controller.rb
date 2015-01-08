class TratamientosController < ApplicationController
	def index
		
	end
	def new 
		@tratamiento = Tratamiento.new #CREA UN OBJETO TIPO TRATAMIENTO 
		@tratamiento.item_tratamientos.build #permite crear itemtratamientos
	end
	def create
		@tratamiento = Tratamiento.new(tratamiento_params)
		if @tratamiento.save
			redirect_to new_tratamiento_path, :notice => "GUARDADO"
		else
			raise
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
		params.require(:tratamiento).permit(:nombre,
		 :numeracion, 
		 :item_tratamientos_attributes=>[ :codigo, :nombre, :tratamiento_id, :_destroy]
		 )	
	end	
end

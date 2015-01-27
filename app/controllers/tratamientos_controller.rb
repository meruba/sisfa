class TratamientosController < ApplicationController
	def index
		
	end
	def new 
		@tratamiento = Tratamiento.new #CREA UN OBJETO TIPO TRATAMIENTO 
		@tratamiento.item_tratamientos.build #permite crear itemtratamientos
	end
	def create
		raise
		@tratamiento = Tratamiento.new(tratamiento_params)
		@tratamiento.save
		respond_to do |format|
			format.js
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
		raise
		params.require(:tratamiento).permit(:nombre,
		 :numeracion, 
		 :item_tratamientos_attributes=>[ :codigo, :nombre, :tratamiento_id, :_destroy]
		 )	
	end	
end

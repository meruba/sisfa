class HorariosController < ApplicationController
	def index
		
	end
	def new 
		@horario = Horario.new #CREA UN OBJETO TIPO TRATAMIENTO 
		@horarios = Horario.all
	end
	def create
		@horario = Horario.new(horario_params)
		if @horario.save
			redirect_to new_horario_path, :notice => "GUARDADO"
		else
			raise
			redirect_to new_horario_path, :notice => "NO GUARDADO"	
		end	
	end
	def edit

	end
	def update

	end
	def anular

	end	
	
	private

	def horario_params
		params.require(:horario).permit(:hora)	
	end	
end

class HorariosController < ApplicationController
	def index

	end
	def new
		@horario = Horario.new #CREA UN OBJETO TIPO TRATAMIENTO
		@horarios = Horario.all
	end
	def create
		@horario = Horario.new(horario_params)
		@horario.save
		respond_to do |format|
			format.js
		end
	end

	def edit

	end

	def update

	end

	def suspender
		raise
    if @horario.anulado
      @horario.anulado = false
    else
      @horario.anulado = true
    end
    @horario.save
    redirect_to configuraciones_fisiatria_index_path, :notice => "Anulado"
	end


	private

	def horario_params
		params.require(:horario).permit(:hora, :hora_inicio, :hora_final)
	end
end

class AsignarHorariosController < ApplicationController
	def new
		@horario = AsignarHorario.new
	end
	def create
		@horario = AsignarHorario.new(horario_params)
		if @horario.save
			redirect_to new_horario_path, :notice => "GUARDADO"
		else
			# raise
			redirect_to new_horario_path, :notice => "NO GUARDADO"	
		end	
	end
	
	def edit

	end

	def update

	end

	private 

	def horario_params
		params.require(:asignar_horario).permit(:paciente_id,:numero_terapias, :fecha_inicio, :fecha_final
			)	
	end	
end

class AsignarHorariosController < ApplicationController

def new
	@horario = AsignarHorario.new
	@horario.tratamiento_registros.build
	respond_to do |format|
    format.js
  end
end

def create
	@horario = AsignarHorario.new(horario_params)
	respond_to do |format|
    format.js
  end
	# if @horario.save
	# 	redirect_to calendario_index_path, :notice => "GUARDADO"
	# else
	# 		# raise
	# 		redirect_to calendario_index_path, :notice => "NO GUARDADO"
	# 	end
	end

	def edit

	end

	def update

	end

	private

	def horario_params
		params.require(:asignar_horario).permit(:paciente_id,
			:numero_terapias,
			:fecha_inicio,
			:fecha_final,
			:horario_id,
			:tratamiento_registros_attributes => [
				:nombre_tratamiento,
				:asignar_horario_id,
				:item_tratamiento_id,
				:_destroy
			]
			)
	end
end

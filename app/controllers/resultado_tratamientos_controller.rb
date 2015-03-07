class ResultadoTratamientosController < ApplicationController
	before_filter :find_resultado, :only => [:edit, :update]
	def by_day
		@fecha = params[:dia].to_date
		@horarios = Horario.all
		respond_to do |format|
			format.js
		end
	end

	def hour_and_day
		fecha = params[:dia].to_date
		@hora = params[:hora]
		@turnos = ResultadoTratamiento.includes(:asignar_horario).where(:fecha => fecha.beginning_of_day..fecha.end_of_day)
		respond_to do |format|
			format.js
		end
	end

	def edit
	end

	def update
		respond_to do |format|
			if @resultado.update(resultado_tratamiento_params.merge(atendido: true))
        format.html { redirect_to calendario_index_path, notice: 'Almacenado' }
      else
        format.html { render 'edit' }
			end
		end
	end
	private

	def resultado_tratamiento_params
		params.require(:resultado_tratamiento).permit(:personal_id,
		 :resultado,
		 :atendido,
		 :razon_editado,
		 :fecha
		 )
	end

	def find_resultado
		@resultado = ResultadoTratamiento.find(params[:id])
	end
end

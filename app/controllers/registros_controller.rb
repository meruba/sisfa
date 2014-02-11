class RegistrosController < ApplicationController

	def index
		
	end

	def new
		@registro = Registro.new
		@registro.build_cliente
	end

	def create
    @registro = Registro.new(registro_params)
    if @registro.save
    	render 'index'
    else
    	render 'index'
    end
	end

	private

	def registro_params
    params.require(:cliente).permit :n_hclinica, 
    																:fecha_de_ingreso,
    																:fecha_de_salida,
    																:especialidad,
    																:medico_asignado
	end
end

class NotaEnfermerasController < ApplicationController
	before_action :find_nota, only: [:show]
	
	def show
		@registro = ItemNotaEnfermera.new
		@notas = @nota.item_nota_enfermeras
	end
	
	private

	def find_nota
		@nota  = NotaEnfermera.find_by_hospitalizacion_registro_id(params[:id])
	end
end

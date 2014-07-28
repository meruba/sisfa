class NotaEnfermerasController < ApplicationController
	before_filter :require_login
  before_filter :is_admin_or_enfermera_enfermeria
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

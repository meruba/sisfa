class AsignacionCamasController < ApplicationController
	before_filter :require_login
  before_filter :is_admin_or_enfermera_enfermeria
	before_action :find_hospitalizado, only: [:new, :create]

	def new
		@asignacion = AsignacionCama.new		
    respond_to do |format|
      format.js
    end
	end

	def index
	end

	def create
		@asignacion = AsignacionCama.new(asignacion_cama_params)
		@asignacion.hospitalizacion_registro = @hospitalizado
    @asignacion.save
    respond_to do |format|
      format.js{@hospitalizado}
    end
	end

	private
	def asignacion_cama_params
		params.require(:asignacion_cama).permit :hospitalizacion_registro_id, :cama_id, :numero_cama
	end

	def find_hospitalizado
		@hospitalizado = HospitalizacionRegistro.find(params[:hospitalizacion_registro_id])
	end
end

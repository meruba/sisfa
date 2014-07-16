class EntregaTurnosController < ApplicationController
  before_action :find_entrega, only: [:show]
  before_action :find_entrega_to_item, only: [:view_create_item]
	
	def index
		@hoja = EntregaTurno.new
		@hojas = EntregaTurno.where(:fecha => Time.now.beginning_of_day..Time.zone.now)
		@hojas_semana = EntregaTurno.where(:fecha => 4.days.ago.beginning_of_day.. Date.yesterday.end_of_day)
	end

	def new
		@hoja = EntregaTurno.new
		respond_to do |format|
      format.js
    end
	end

	def create
		@hoja = EntregaTurno.new(entrega_turno_params.merge(fecha: Time.now))
		@hoja.save
		respond_to do |format|
      format.js
    end
	end

	def show
		items = @entrega.item_entrega_turnos.includes(hospitalizacion_registro: [:paciente => :cliente])
		@examenes = items.where(:tipo_item => "examen")
		@ayunas = items.where(:tipo_item => "ayuna")
		@aislamientos = items.where(:tipo_item => "aislamiento")
		@defunciones = items.where(:tipo_item => "defuncion")
		@movimientos = items.where(:tipo_item => "movimiento")
		@graves = items.where(:tipo_item => "grave")
	end

	def view_create_item
		@item = ItemEntregaTurno.new
		show()
	end

	private

	def entrega_turno_params
		params.require(:entrega_turno).permit(:fecha,
      :servicio)
	end

	def find_entrega
  	@entrega = EntregaTurno.find(params[:id])		
	end

	def find_entrega_to_item
  	@entrega = EntregaTurno.find(params[:entrega_turno_id])	
	end
end

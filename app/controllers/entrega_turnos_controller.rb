class EntregaTurnosController < ApplicationController
	before_filter :require_login
  before_filter :is_admin_or_enfermera_enfermeria
	before_action :find_entrega, only: [:show, :destroy]
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
		@items = @entrega.item_entrega_turnos.includes([hospitalizacion_registro: [:paciente => :cliente]],[:user])
		@examenes , @ayunas, @aislamientos, @defunciones, @movimientos, @graves = [], [], [], [], [], []
		@items.each do |item|
			@examenes << item if item.tipo_item == 'examen'
			@ayunas << item if item.tipo_item == 'ayuna'
			@aislamientos << item if item.tipo_item == 'aislamiento'
			@defunciones << item if item.tipo_item == 'defuncione'
			@movimientos << item if item.tipo_item == 'movimiento'
			@graves << item if item.tipo_item == 'grave'
		end
	end

	def view_create_item
		@item = ItemEntregaTurno.new
		show()
	end
	
	def destroy
		@entrega.destroy
		respond_to do |format|
			format.js
		end
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
